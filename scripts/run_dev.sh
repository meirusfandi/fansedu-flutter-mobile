#!/usr/bin/env bash
# Run app dengan flavor dev (dari project root)
set -e
fvm flutter run -t lib/main_dev.dart --flavor dev --dart-define=FLAVOR=dev --dart-define=API_BASE_URL=https://api-dev.example.com "$@"
