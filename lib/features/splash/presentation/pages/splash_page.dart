import 'package:flutter/material.dart';

import 'package:fansedu_flutter_mobile/core/constants/app_assets.dart';
import 'package:fansedu_flutter_mobile/core/constants/app_colors.dart';
import 'package:fansedu_flutter_mobile/core/injection/injection.dart';
import 'package:fansedu_flutter_mobile/core/storage/intro_storage.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:fansedu_flutter_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:fansedu_flutter_mobile/features/home/presentation/pages/home_page.dart';
import 'package:fansedu_flutter_mobile/features/introduction/presentation/pages/introduction_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future<void>.delayed(const Duration(milliseconds: 2200));
    if (!mounted) return;
    final introStorage = sl<IntroStorage>();
    final hasSeenIntro = await introStorage.hasSeenIntro();
    if (!mounted) return;
    Widget next;
    if (!hasSeenIntro) {
      next = const IntroductionPage();
    } else {
      final token = await sl<AuthRepository>().getToken();
      next = (token != null && token.isNotEmpty)
          ? const HomePage()
          : const LoginPage();
    }
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => next),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBackground : Colors.white,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Image.asset(
                AppAssets.logo,
                height: 160,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.school_rounded,
                  size: 120,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(flex: 2),
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
