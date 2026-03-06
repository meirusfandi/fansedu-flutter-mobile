import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fansedu_flutter_mobile/core/constants/env.dart';
import 'package:fansedu_flutter_mobile/core/injection/injection.dart';
import 'package:fansedu_flutter_mobile/core/theme/app_theme.dart';
import 'package:fansedu_flutter_mobile/core/theme/theme_cubit.dart';
import 'package:fansedu_flutter_mobile/core/theme/theme_state.dart';
import 'package:fansedu_flutter_mobile/features/splash/presentation/pages/splash_page.dart';
import 'package:fansedu_flutter_mobile/l10n/generated/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (_) => sl<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        buildWhen: (prev, curr) => prev.mode != curr.mode,
        builder: (context, themeState) {
          return MaterialApp(
            title: Env.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeState.mode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
