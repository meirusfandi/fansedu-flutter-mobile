/// Environment / API config. Di-set via --dart-define dari build variant.
class Env {
  Env._();

  /// Build variant: dev | staging | prod
  static const String flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'dev',
  );

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: '',
  );

  static bool get isDev => flavor == 'dev';
  static bool get isStaging => flavor == 'staging';
  static bool get isProd => flavor == 'prod';

  /// Nama app per flavor (bisa dipakai di UI).
  static String get appName {
    return switch (flavor) {
      'staging' => 'Fansedu (Staging)',
      'prod' => 'Fansedu',
      _ => 'Fansedu Dev',
    };
  }
}
