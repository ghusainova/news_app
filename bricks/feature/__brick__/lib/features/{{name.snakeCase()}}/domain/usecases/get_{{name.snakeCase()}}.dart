import 'package:injectable/injectable.dart';

import 'package:news_app/core/error/result.dart';
import 'package:news_app/features/{{name.snakeCase()}}/domain/entities/{{name.snakeCase()}}.dart';
import 'package:news_app/features/{{name.snakeCase()}}/domain/repositories/{{name.snakeCase()}}_repository.dart';

@lazySingleton
class Get{{name.pascalCase()}} {
  final {{name.pascalCase()}}Repository repository;

  Get{{name.pascalCase()}}(this.repository);

  Future<Result<{{name.pascalCase()}}>> call() => repository.get{{name.pascalCase()}}();
}

