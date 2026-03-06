import 'package:flutter/material.dart';

import 'package:fansedu_flutter_mobile/app.dart';
import 'package:fansedu_flutter_mobile/core/injection/injection.dart';

/// Entry point **staging**. Jalankan dengan:
/// ```bash
/// flutter run -t lib/main_stg.dart --flavor staging --dart-define=FLAVOR=staging --dart-define=API_BASE_URL=https://api-staging.example.com
/// ```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}
