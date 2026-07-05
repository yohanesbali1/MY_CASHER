import 'package:get_it/get_it.dart';
import 'package:my_casher/feature/category_product/data/repository/category_product_repository.dart';
import 'package:my_casher/feature/category_product/presentation/bloc/category_product_bloc.dart';
import 'package:my_casher/feature/home/presentation/bloc/home_bloc.dart';
import 'package:my_casher/feature/iventory/presentation/bloc/iventory_bloc.dart';
import 'package:my_casher/feature/product/data/repository/product_repository.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';
import 'package:my_casher/feature/theme/presentation/bloc/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton<ThemeBloc>(() => ThemeBloc());

  sl.registerLazySingleton<CategoryProductRepository>(
    () => CategoryProductRepository(),
  );
  sl.registerLazySingleton<ProductRepository>(() => ProductRepository());

  sl.registerLazySingleton<ProductBloc>(
    () => ProductBloc(sl<ProductRepository>(), sl<CategoryProductRepository>()),
  );

  sl.registerLazySingleton<CategoryProductBloc>(
    () => CategoryProductBloc(sl<CategoryProductRepository>()),
  );

  sl.registerLazySingleton<IventoryBloc>(
    () => IventoryBloc(
      categoryBloc: sl<CategoryProductBloc>(),
      productBloc: sl<ProductBloc>(),
    ),
  );

  sl.registerLazySingleton<HomeBloc>(
    () => HomeBloc(iventoryBloc: sl<IventoryBloc>()),
  );
}
