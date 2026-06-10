import 'package:injectable/injectable.dart';

import 'package:news_app/features/{{name.snakeCase()}}/data/datasources/{{name.snakeCase()}}_remote_datasource.dart';
import 'package:news_app/features/{{name.snakeCase()}}/domain/repositories/{{name.snakeCase()}}_repository.dart';

@LazySingleton(as: {{name.pascalCase()}}Repository)
class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {
  final {{name.pascalCase()}}RemoteDataSource remote;

  {{name.pascalCase()}}RepositoryImpl({required this.remote});

  @override
  Future<dynamic> get{{name.pascalCase()}}() async {
    try {
      return await remote.fetch{{name.pascalCase()}}();
    } catch (e) {
      throw Exception('Failed to load {{name.snakeCase()}}: $e');
    }
  }
}

