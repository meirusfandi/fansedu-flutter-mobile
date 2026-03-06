import 'package:flutter/material.dart';

import 'package:fansedu_flutter_mobile/app.dart';
import 'package:fansedu_flutter_mobile/core/injection/injection.dart';

/// Entry point **development**. Jalankan dengan:
/// ```bash
/// flutter run -t lib/main_dev.dart --flavor dev --dart-define=FLAVOR=dev --dart-define=API_BASE_URL=https://api-dev.example.com
/// ```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}
