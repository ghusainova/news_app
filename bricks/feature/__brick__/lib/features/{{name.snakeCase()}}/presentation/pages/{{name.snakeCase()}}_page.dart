import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/di/injection.dart' as di;
import 'package:news_app/features/{{name.snakeCase()}}/presentation/bloc/{{name.snakeCase()}}_bloc.dart';

class {{name.pascalCase()}}Page extends StatelessWidget {
  const {{name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<{{name.pascalCase()}}Bloc>(
      create: (_) => di.getIt<{{name.pascalCase()}}Bloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('{{name.pascalCase()}}')),
        body: BlocBuilder<{{name.pascalCase()}}Bloc, {{name.pascalCase()}}State>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              ready: (value) => Center(child: Text(value.id)),
              error: (message) => Center(child: Text(message)),
            );
          },
        ),
      ),
    );
  }
}

