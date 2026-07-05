import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/category_product/presentation/bloc/category_product_bloc.dart';
import 'package:my_casher/feature/home/presentation/bloc/home_bloc.dart';
import 'package:my_casher/feature/iventory/presentation/bloc/iventory_bloc.dart';
import 'package:my_casher/feature/pos/presentation/bloc/pos_bloc.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';
import 'package:my_casher/feature/theme/presentation/bloc/theme_bloc.dart';

import '../core/di/injection.dart';

class AppProviders {
  static List<BlocProvider> providers = [
    BlocProvider<ThemeBloc>(
      create: (_) => sl<ThemeBloc>()..add(ThemeInitialized()),
    ),
    BlocProvider<HomeBloc>(
      create: (_) => sl<HomeBloc>()..add(HomeInitialized()),
    ),
    BlocProvider<PosBloc>(create: (_) => sl<PosBloc>()..add(PosStarted())),
    BlocProvider<IventoryBloc>(create: (_) => sl<IventoryBloc>()),
    BlocProvider<CategoryProductBloc>(create: (_) => sl<CategoryProductBloc>()),
    BlocProvider<ProductBloc>(create: (_) => sl<ProductBloc>()),
  ];
}
