part of '{{name.snakeCase()}}_bloc.dart';

@freezed
class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  const factory {{name.pascalCase()}}State.initial() = _Initial;
  const factory {{name.pascalCase()}}State.loading() = _Loading;
  const factory {{name.pascalCase()}}State.ready({required {{name.pascalCase()}} value}) =
      _Ready;
  const factory {{name.pascalCase()}}State.error({required String message}) =
      _Error;
}

