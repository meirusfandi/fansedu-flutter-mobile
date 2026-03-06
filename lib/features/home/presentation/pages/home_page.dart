import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fansedu_flutter_mobile/core/constants/app_assets.dart';
import 'package:fansedu_flutter_mobile/core/injection/injection.dart';
import 'package:fansedu_flutter_mobile/core/theme/theme_cubit.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:fansedu_flutter_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:fansedu_flutter_mobile/l10n/generated/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppAssets.logo,
              height: 32,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(Icons.school),
            ),
            const SizedBox(width: 10),
            Text(l10n.appTitle),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6_outlined),
            tooltip: l10n.theme,
            onPressed: () => context.read<ThemeCubit>().toggleDark(),
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            tooltip: 'Logout',
            onPressed: () async {
              await sl<AuthRepository>().clearToken();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(builder: (_) => const LoginPage()),
                (_) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          l10n.appTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
