import 'package:flutter/material.dart';
import 'package:jak_doczlapie/app/router.dart';
import 'package:jak_doczlapie/app/theme.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme();

    return MaterialApp.router(
      theme: theme.light,
      darkTheme: theme.dark,
      routerConfig: _appRouter.config(),
    );
  }
}
