#!/usr/bin/env bash
# Setup project with FVM and code generation (run from project root)

set -e

echo "Using FVM Flutter 3.35.7..."
fvm use 3.35.7 --force

echo "Installing dependencies..."
fvm flutter pub get

echo "Generating Freezed & JSON code..."
fvm dart run build_runner build --delete-conflicting-outputs

echo "Generating l10n..."
fvm flutter gen-l10n

echo "Done. Run with: fvm flutter run"
