import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

// ---------------------------------------------------------------------------
// Dependency Injection — GetIt
//
// Rule: everything registered here should be swappable (e.g. swap impls in tests).
// Example: NewsRepositoryImpl → MockNewsRepository in one line.
//
// Registration order: Infrastructure → Data → Domain → Presentation
// ---------------------------------------------------------------------------

final GetIt getIt = GetIt.instance;

String _resolveNewsApiKey() {
  final dartDefineKey = const String.fromEnvironment('NEWS_API_KEY');
  String? dotenvKey;
  try {
    dotenvKey = dotenv.env['NEWS_API_KEY'];
  } catch (_) {
    dotenvKey = null;
  }

  final resolved = dartDefineKey.isNotEmpty ? dartDefineKey : (dotenvKey ?? '');

  if (resolved.isEmpty) {
    throw StateError(
      'Missing NEWS_API_KEY. Provide it via --dart-define=NEWS_API_KEY=... or a local .env file.',
    );
  }

  return resolved;
}

@InjectableInit()
Future<void> _configureDependencies() => getIt.init();

Future<void> initDependencies() async {
  // Values used by @Named injections.
  if (!getIt.isRegistered<String>(instanceName: 'newsBaseUrl')) {
    getIt.registerSingleton<String>(
      'https://newsapi.org/v2',
      instanceName: 'newsBaseUrl',
    );
  }
  if (!getIt.isRegistered<String>(instanceName: 'newsApiKey')) {
    getIt.registerSingleton<String>(
      _resolveNewsApiKey(),
      instanceName: 'newsApiKey',
    );
  }
  if (!getIt.isRegistered<Duration>()) {
    getIt.registerSingleton<Duration>(const Duration(seconds: 30));
  }

  // Generated registrations (injectable).
  await _configureDependencies();
}
