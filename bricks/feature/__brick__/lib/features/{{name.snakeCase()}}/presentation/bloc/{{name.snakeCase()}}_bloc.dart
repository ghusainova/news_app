import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:news_app/features/{{name.snakeCase()}}/domain/usecases/get_{{name.snakeCase()}}.dart';

part 'generated/{{name.snakeCase()}}_bloc.freezed.dart';
part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_state.dart';

@injectable
class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  final Get{{name.pascalCase()}} get{{name.pascalCase()}}UseCase;

  {{name.pascalCase()}}Bloc({required this.get{{name.pascalCase()}}UseCase})
      : super(const {{name.pascalCase()}}State.initial()) {
    on<LoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<{{name.pascalCase()}}State> emit,
  ) async {
    emit(const {{name.pascalCase()}}State.loading());
    try {
      final data = await get{{name.pascalCase()}}UseCase.call();
      emit({{name.pascalCase()}}State.loaded(data));
    } catch (e) {
      emit({{name.pascalCase()}}State.error(e.toString()));
    }
  }
}

