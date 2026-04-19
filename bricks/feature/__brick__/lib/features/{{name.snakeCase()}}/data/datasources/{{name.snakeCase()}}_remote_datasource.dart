abstract class {{name.pascalCase()}}RemoteDataSource {
  Future<String> fetch{{name.pascalCase()}}Id();
}

class {{name.pascalCase()}}RemoteDataSourceImpl implements {{name.pascalCase()}}RemoteDataSource {
  @override
  Future<String> fetch{{name.pascalCase()}}Id() async {
    return '{{name.snakeCase()}}_id';
  }
}

