import 'package:injectable/injectable.dart';

abstract class {{name.pascalCase()}}RemoteDataSource {
  Future<dynamic> fetch{{name.pascalCase()}}();
}

@LazySingleton(as: {{name.pascalCase()}}RemoteDataSource)
class {{name.pascalCase()}}RemoteDataSourceImpl implements {{name.pascalCase()}}RemoteDataSource {
  @override
  Future<dynamic> fetch{{name.pascalCase()}}() async {
    // TODO: Implement API call using Retrofit
    throw UnimplementedError('Implement fetch{{name.pascalCase()}}');
  }
}

