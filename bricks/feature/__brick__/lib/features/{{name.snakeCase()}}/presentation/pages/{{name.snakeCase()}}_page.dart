import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/{{name.snakeCase()}}/presentation/bloc/{{name.snakeCase()}}_bloc.dart';

class {{name.pascalCase()}}Page extends StatelessWidget {
  const {{name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{{name.pascalCase()}}')),
      body: BlocProvider<{{name.pascalCase()}}Bloc>(
        create: (_) => getIt<{{name.pascalCase()}}Bloc>()..add(const {{name.pascalCase()}}Event.loadRequested()),
        child: BlocBuilder<{{name.pascalCase()}}Bloc, {{name.pascalCase()}}State>(
          builder: (context, state) {
            return state.whenOrNull(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (data) => Center(child: Text('Data loaded: $data')),
              error: (message) => Center(child: Text(message)),
            ) ?? const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

