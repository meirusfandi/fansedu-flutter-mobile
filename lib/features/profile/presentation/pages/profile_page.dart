import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fansedu_flutter_mobile/core/constants/app_colors.dart';
import 'package:fansedu_flutter_mobile/core/injection/injection.dart';
import 'package:fansedu_flutter_mobile/core/theme/theme_cubit.dart';
import 'package:fansedu_flutter_mobile/core/theme/theme_state.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:fansedu_flutter_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:fansedu_flutter_mobile/l10n/generated/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserEntity? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await sl<AuthRepository>().getStoredUser();
    if (mounted) setState(() => _user = user);
  }

  Future<void> _logout() async {
    await sl<AuthRepository>().clearToken();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 24),
          CircleAvatar(
            radius: 48,
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            child: Text(
              _user?.name?.isNotEmpty == true
                  ? (_user!.name!.length > 1 ? _user!.name!.substring(0, 2).toUpperCase() : _user!.name!.toUpperCase())
                  : (_user?.email.isNotEmpty == true ? _user!.email.substring(0, 1).toUpperCase() : '?'),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _user?.name ?? _user?.email ?? '—',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          if (_user?.email.isNotEmpty == true) ...[
            const SizedBox(height: 4),
            Text(
              _user!.email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
          const SizedBox(height: 32),
          _SectionHeader(title: l10n.account),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(l10n.editProfile),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              final themeLabel = switch (themeState.mode) {
                ThemeMode.light => l10n.themeLight,
                ThemeMode.dark => l10n.themeDark,
                _ => l10n.themeSystem,
              };
              return ListTile(
                leading: Icon(Icons.brightness_6_outlined, color: Theme.of(context).iconTheme.color),
                title: Text(l10n.theme),
                subtitle: Text(themeLabel),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.read<ThemeCubit>().toggleDark(),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout_rounded, size: 20),
              label: Text(l10n.logout),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
