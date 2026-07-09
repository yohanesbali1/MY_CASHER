import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_casher/feature/home/presentation/bloc/home_bloc.dart';
import 'package:my_casher/feature/home/presentation/page/home_page.dart';
import 'package:my_casher/feature/pos/presentation/page/payment_success_page.dart';
import 'package:my_casher/feature/pos/presentation/page/qris_payment_page.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';
import 'package:my_casher/feature/product/presentation/page/product_add_page.dart';

import '../core/di/injection.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => sl<HomeBloc>()..add(HomeInitialized()),
            child: HomePage(),
          );
        },
      ),

      GoRoute(
        path: '/product/create',
        builder: (context, state) {
          final bloc = state.extra as ProductBloc;

          bloc
            ..add(ProductReset())
            ..add(ProductModeChange(FormMode.create));
          return BlocProvider.value(
            value: state.extra as ProductBloc,
            child: const AddProductPage(),
          );
        },
      ),

      GoRoute(
        path: '/pos/qris',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return QrisPaymentPage(
            cart: extra['cart'],
            total: extra['total'],
            totalItem: extra['totalItem'],
          );
        },
      ),

      GoRoute(
        path: '/pos/payment-success',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;

          return PaymentSuccessPage(
            isCash: extra['isCash'],
            change: extra['change'],
          );
        },
      ),
    ],
  );
}
