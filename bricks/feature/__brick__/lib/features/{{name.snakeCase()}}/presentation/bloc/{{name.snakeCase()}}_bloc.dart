import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:news_app/features/{{name.snakeCase()}}/domain/usecases/get_{{name.snakeCase()}}.dart';

part 'generated/{{name.snakeCase()}}_bloc.freezed.dart';
part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_state.dart';

@injectable
class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  final Get{{name.pascalCase()}} get{{name.pascalCase()}};

  {{name.pascalCase()}}Bloc({required this.get{{name.pascalCase()}})
      : super(const {{name.pascalCase()}}State.initial()) {
    on<_Requested>(_onRequested);
    add(const {{name.pascalCase()}}Event.requested());
  }

  Future<void> _onRequested(
    _Requested event,
    Emitter<{{name.pascalCase()}}State> emit,
  ) async {
    emit(const {{name.pascalCase()}}State.loading());
    final result = await get{{name.pascalCase()}}();

    result.when(
      success: (value) => emit({{name.pascalCase()}}State.ready(value: value)),
      failure: (failure) =>
          emit({{name.pascalCase()}}State.error(message: failure.message)),
    );
  }
}

