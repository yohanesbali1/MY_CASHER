import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_casher/app/providers.dart';
import 'package:my_casher/core/bloc/app_bloc_observer.dart';
import 'package:my_casher/core/database/app_database.dart';

import 'app/app.dart';
import 'core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID');

  await configureDependencies();

  await AppDatabase.instance.database;

  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(providers: AppProviders.providers, child: const App()),
  );
}
