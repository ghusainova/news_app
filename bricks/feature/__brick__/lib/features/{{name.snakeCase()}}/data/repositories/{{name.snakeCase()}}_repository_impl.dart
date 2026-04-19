import 'package:injectable/injectable.dart';

import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/error/result.dart';
import 'package:news_app/features/{{name.snakeCase()}}/data/datasources/{{name.snakeCase()}}_remote_datasource.dart';
import 'package:news_app/features/{{name.snakeCase()}}/domain/entities/{{name.snakeCase()}}.dart';
import 'package:news_app/features/{{name.snakeCase()}}/domain/repositories/{{name.snakeCase()}}_repository.dart';

@LazySingleton(as: {{name.pascalCase()}}Repository)
class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {
  final {{name.pascalCase()}}RemoteDataSource remote;

  {{name.pascalCase()}}RepositoryImpl({required this.remote});

  @override
  Future<Result<{{name.pascalCase()}}>> get{{name.pascalCase()}}() async {
    try {
      final id = await remote.fetch{{name.pascalCase()}}Id();
      return Result.success({{name.pascalCase()}}(id: id));
    } catch (_) {
      return const Result.failure(UnknownFailure());
    }
  }
}

