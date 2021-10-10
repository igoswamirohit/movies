import 'package:get_it/get_it.dart';

import 'src/core/service/link_outside_world.dart';
import 'src/data/datasources/movies_remote_datasource.dart';
import 'src/data/repositories/movies_repository.dart';
import 'src/domain/repositories/product_repository.dart';
import 'src/domain/usecases/movies_usecase.dart';
import 'src/presentation/blocs/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

    //Service
  sl.registerLazySingleton<LinkToOutSideWorld>(() => LinkToOutSideWorld());

  // Feature - Movies - Start

  // Bloc
  sl.registerFactory(
    () => MoviesBloc(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => FetchMoviesUseCase(sl()));

  // Repository
  sl.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(sl()),
  );

  // Feature - Movies End
}
