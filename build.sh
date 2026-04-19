#!/bin/bash

echo "🔧 Running build_runner for code generation..."
dart pub get
dart run build_runner build --delete-conflicting-outputs

if [ $? -eq 0 ]; then
    echo "✅ Code generation completed successfully!"
else
    echo "❌ Code generation failed!"
    exit 1
fi
