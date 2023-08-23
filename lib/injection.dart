import 'package:get_it/get_it.dart';
import 'package:unlimit_assignment/data/datasources/local/local_data_source.dart';
import 'package:unlimit_assignment/data/datasources/remote/remote_data_source.dart';
import 'package:unlimit_assignment/data/repositories/joke_repository_impl.dart';
import 'package:unlimit_assignment/domain/repositories/joke_repository.dart';
import 'package:unlimit_assignment/domain/usecases/get_jokes.dart';
import 'package:unlimit_assignment/presentation/blocs/joke/joke_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() async {
  //bloc
  locator.registerFactory(() => JokeBloc(locator()));

  // use case

  locator.registerLazySingleton(() => GetNewJoke(repository: locator()));

  // data source
  locator.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: locator(), localDataSource: locator()),
  );
  // repository
  locator.registerLazySingleton<JokeRepository>(() => JokeRepositoryImpl(
      remoteDataSource: locator(), localDataSource: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
