import 'package:get_it/get_it.dart';
import 'package:my_casher/feature/category_product/presentation/bloc/category_product_bloc.dart';
import 'package:my_casher/feature/home/presentation/bloc/home_bloc.dart';
import 'package:my_casher/feature/iventory/presentation/bloc/iventory_bloc.dart';
import 'package:my_casher/feature/theme/presentation/bloc/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerFactory<ThemeBloc>(() => ThemeBloc());
  sl.registerFactory<HomeBloc>(() => HomeBloc());
  sl.registerFactory<IventoryBloc>(() => IventoryBloc());
  sl.registerFactory<CategoryProductBloc>(() => CategoryProductBloc());
}
