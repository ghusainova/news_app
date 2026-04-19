import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

import 'package:news_app/core/di/injection.dart' as di;
import 'package:news_app/app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    if (kDebugMode) {
      debugPrint('dotenv load failed: $e');
    }
  }
  await di.initDependencies();
  ErrorWidget.builder = (details) {
    return const Material(child: Center(child: Text('Something went wrong')));
  };
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };
  runApp(const MyApp());
}
