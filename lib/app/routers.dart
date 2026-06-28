import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_casher/feature/home/presentation/bloc/home_bloc.dart';
import 'package:my_casher/feature/home/presentation/page/home_page.dart';

import '../core/di/injection.dart';

// import '../features/auth/pages/login_page.dart';
// import '../features/home/bloc/home_bloc.dart';
// import '../features/home/pages/home_page.dart';
// import '../features/help/bloc/help_bloc.dart';
// import '../features/help/pages/help_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      // GoRoute(
      //   path: '/login',
      //   builder: (context, state) {
      //     return const LoginPage();
      //   },
      // ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => sl<HomeBloc>()..add(HomeInitialized()),
            child: HomePage(),
          );
        },
      ),

      // GoRoute(
      //   path: '/help',
      //   builder: (context, state) {
      //     return BlocProvider(
      //       create: (_) => sl<HelpBloc>()..add(HelpStarted()),
      //       child: const HelpPage(),
      //     );
      //   },
      // ),
    ],
  );
}
