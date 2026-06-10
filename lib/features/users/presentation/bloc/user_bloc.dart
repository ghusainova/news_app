import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/features/users/domain/usecases/get_users_usecase.dart';
import 'package:news_app/features/users/data/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'generated/user_bloc.freezed.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;

  UserBloc({required this.getUsersUseCase}) : super(const UserState.initial()) {
    on<LoadUsers>((event, emit) async {
      emit(const UserState.loading());
      try {
        final users = await getUsersUseCase.call();
        emit(UserState.loaded(users));
      } catch (e) {
        emit(UserState.error(e.toString()));
      }
    });
  }
}
