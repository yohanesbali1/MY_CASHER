import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/app/routers.dart';
import 'package:my_casher/core/theme/app_scroll_behavore.dart';
import 'package:my_casher/feature/theme/presentation/bloc/theme_bloc.dart';
import 'package:my_casher/feature/theme/theme/dark_theme.dart';
import 'package:my_casher/feature/theme/theme/light_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            overscroll: false,
          ),
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
