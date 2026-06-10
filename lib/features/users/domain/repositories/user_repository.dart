import 'package:news_app/features/users/data/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers();
}
