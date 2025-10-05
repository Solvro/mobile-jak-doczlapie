import "package:flutter/material.dart";
import "package:toastification/toastification.dart";
import "router.dart";
import "theme.dart";

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme();

    return ToastificationWrapper(
      child: MaterialApp.router(theme: theme.light, darkTheme: theme.dark, routerConfig: _appRouter.config()),
    );
  }
}
