import 'package:news_app/core/error/result.dart';
import 'package:news_app/features/{{name.snakeCase()}}/domain/entities/{{name.snakeCase()}}.dart';

abstract class {{name.pascalCase()}}Repository {
  Future<Result<{{name.pascalCase()}}>> get{{name.pascalCase()}}();
}

