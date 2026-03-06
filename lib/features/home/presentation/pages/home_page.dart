import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fansedu_flutter_mobile/core/constants/app_assets.dart';
import 'package:fansedu_flutter_mobile/core/theme/theme_cubit.dart';
import 'package:fansedu_flutter_mobile/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:fansedu_flutter_mobile/features/notification/presentation/pages/notification_page.dart';
import 'package:fansedu_flutter_mobile/features/profile/presentation/pages/profile_page.dart';
import 'package:fansedu_flutter_mobile/l10n/generated/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const List<_TabItem> _tabs = [
    _TabItem(page: DashboardPage(), labelKey: 'dashboard', icon: Icons.dashboard_rounded),
    _TabItem(page: NotificationPage(), labelKey: 'notifications', icon: Icons.notifications_rounded),
    _TabItem(page: ProfilePage(), labelKey: 'profile', icon: Icons.person_rounded),
  ];

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
            Text(_tabs[_currentIndex].label(l10n)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6_outlined),
            tooltip: l10n.theme,
            onPressed: () => context.read<ThemeCubit>().toggleDark(),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs.map((t) => t.page).toList(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard_rounded),
            label: l10n.dashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.notifications_outlined),
            selectedIcon: const Icon(Icons.notifications_rounded),
            label: l10n.notifications,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline_rounded),
            selectedIcon: const Icon(Icons.person_rounded),
            label: l10n.profile,
          ),
        ],
      ),
    );
  }
}

class _TabItem {
  const _TabItem({
    required this.page,
    required this.labelKey,
    required this.icon,
  });

  final Widget page;
  final String labelKey;
  final IconData icon;

  String label(AppLocalizations l10n) {
    return switch (labelKey) {
      'dashboard' => l10n.dashboard,
      'notifications' => l10n.notifications,
      'profile' => l10n.profile,
      _ => labelKey,
    };
  }
}
