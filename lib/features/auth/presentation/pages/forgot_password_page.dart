import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fansedu_flutter_mobile/core/constants/app_colors.dart';
import 'package:fansedu_flutter_mobile/core/injection/injection.dart';
import 'package:fansedu_flutter_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fansedu_flutter_mobile/features/auth/presentation/cubit/auth_state.dart';
import 'package:fansedu_flutter_mobile/l10n/generated/app_localizations.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.forgotPassword),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Text(
                  l10n.forgotPasswordSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: l10n.email,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return '${l10n.email} required';
                    if (!v.contains('@')) return 'Invalid email';
                    return null;
                  },
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (prev, curr) => curr.errorMessage != null,
                  builder: (context, state) {
                    if (state.errorMessage == null) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        state.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                BlocConsumer<AuthCubit, AuthState>(
                  listenWhen: (prev, curr) =>
                      curr.status != AuthStatus.loading && prev.status == AuthStatus.loading,
                  listener: (context, state) async {
                    if (state.errorMessage == null && state.status == AuthStatus.initial) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.resetLinkSent)),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  buildWhen: (prev, curr) => prev.status != curr.status,
                  builder: (context, state) {
                    return FilledButton(
                      onPressed: state.status == AuthStatus.loading
                          ? null
                          : () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                await context.read<AuthCubit>().forgotPassword(
                                      _emailController.text.trim(),
                                    );
                              }
                            },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: state.status == AuthStatus.loading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.sendResetLink),
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.backToLogin),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
