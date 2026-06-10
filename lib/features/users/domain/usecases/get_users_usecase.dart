import 'package:injectable/injectable.dart';
import 'package:news_app/features/users/data/models/user_model.dart';
import 'package:news_app/features/users/domain/repositories/user_repository.dart';

@lazySingleton
class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  Future<List<UserModel>> call() async {
    return await repository.getUsers();
  }
}
