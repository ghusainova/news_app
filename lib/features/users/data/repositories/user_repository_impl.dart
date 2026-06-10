import 'package:injectable/injectable.dart';
import 'package:news_app/features/users/data/datasources/user_remote_ds.dart';
import 'package:news_app/features/users/data/models/user_model.dart';
import 'package:news_app/features/users/domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  Future<List<UserModel>> getUsers() async {
    try {
      final users = await remoteDataSource.getUsers();
      return users;
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
