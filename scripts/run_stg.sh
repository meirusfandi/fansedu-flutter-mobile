#!/usr/bin/env bash
# Run app dengan flavor staging (dari project root)
set -e
fvm flutter run -t lib/main_stg.dart --flavor staging --dart-define=FLAVOR=staging --dart-define=API_BASE_URL=https://api-staging.example.com "$@"
