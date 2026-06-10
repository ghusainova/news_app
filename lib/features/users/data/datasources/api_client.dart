import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/features/users/data/models/users_model.dart';
import 'package:retrofit/http.dart';

part 'generated/api_client.g.dart';

@singleton
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;
  @GET('/users')
  Future<UsersModel> getUsers();
}
