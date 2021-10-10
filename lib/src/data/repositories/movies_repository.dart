

import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/movies_usecase.dart';
import '../datasources/movies_remote_datasource.dart';
import '../models/movie_model.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remoteDataSource;

  MoviesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<MoviesModel> getMovies(FetchMoviesParams fetchProductsParams) async {
    return remoteDataSource.getMovieList(fetchProductsParams);
  }
}
