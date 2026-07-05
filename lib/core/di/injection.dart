import 'package:get_it/get_it.dart';
import 'package:my_casher/feature/category_product/data/datasource/category_local_datasource.dart';
import 'package:my_casher/feature/category_product/data/repository/category_product_repository.dart';
import 'package:my_casher/feature/category_product/presentation/bloc/category_product_bloc.dart';
import 'package:my_casher/feature/home/presentation/bloc/home_bloc.dart';
import 'package:my_casher/feature/iventory/presentation/bloc/iventory_bloc.dart';
import 'package:my_casher/feature/pos/data/datasource/cart_local_datasource.dart';
import 'package:my_casher/feature/pos/data/repository/cart_repository.dart';
import 'package:my_casher/feature/pos/presentation/bloc/pos_bloc.dart';
import 'package:my_casher/feature/product/data/datasource/product_local_datasource.dart';
import 'package:my_casher/feature/product/data/repository/product_repository.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';
import 'package:my_casher/feature/theme/presentation/bloc/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton<ThemeBloc>(() => ThemeBloc());

  sl.registerLazySingleton<ProductLocalDatasource>(
    () => ProductLocalDatasource(),
  );

  sl.registerLazySingleton<CategoryLocalDatasource>(
    () => CategoryLocalDatasource(),
  );

  sl.registerLazySingleton<CartLocalDatasource>(() => CartLocalDatasource());

  sl.registerLazySingleton<CartRepository>(
    () => CartRepository(sl<CartLocalDatasource>()),
  );

  sl.registerLazySingleton<CategoryProductRepository>(
    () => CategoryProductRepository(CategoryLocalDatasource()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepository(ProductLocalDatasource()),
  );

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

  sl.registerLazySingleton<PosBloc>(
    () => PosBloc(
      repository: sl<ProductRepository>(),
      categoryRepository: sl<CategoryProductRepository>(),
    ),
  );
}
