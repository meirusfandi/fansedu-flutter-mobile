#!/usr/bin/env bash
# Run app production (dari project root)
set -e
fvm flutter run -t lib/main.dart --flavor prod --dart-define=FLAVOR=prod --dart-define=API_BASE_URL=https://api.fansedu.web.id "$@"
