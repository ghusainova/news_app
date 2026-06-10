import 'package:injectable/injectable.dart';
import 'package:news_app/features/users/data/datasources/api_client.dart';
import 'package:news_app/features/users/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final usersModel = await apiClient.getUsers();
      return usersModel.users;
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
