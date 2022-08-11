import 'core/network/network_info.dart';
import 'features/TRIVIA_APP_TESTE/data/datasources/TRIVIA_REMOTE_SOURCE.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/util/input_converter.dart';
import 'features/TRIVIA_APP_TESTE/data/datasources/TRIVIA_DATASOURCE.dart';
import 'features/TRIVIA_APP_TESTE/data/repositories/TRIVIA_REPO.dart';
import 'features/TRIVIA_APP_TESTE/domain/respositories/TRIVIA_REPOSITORIO_DOMAIN.dart';
import 'features/TRIVIA_APP_TESTE/domain/usecases/PEGAR_NUMERO_TRIVIA_EQUATABLE.dart';
import 'features/TRIVIA_APP_TESTE/presentation/bloc/TRIVIA_BLOC.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'features/TRIVIA_APP_TESTE/domain/usecases/RANDOMIZAR_BOTAO_USECASE.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Features - NumberTrivia
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          ));
  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
