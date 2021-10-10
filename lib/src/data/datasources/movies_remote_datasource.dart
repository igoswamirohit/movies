

import '../../core/service/link_outside_world.dart';

import '../../core/constants/api_constants.dart';
import '../../domain/usecases/movies_usecase.dart';
import '../models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  /// Calls the http://api.themoviedb.org/3/search/movie?api_key=6753d9119b9627493ae129f3c3c99151&query=superman&page=1 endpoint.
  Future<MoviesModel> getMovieList(FetchMoviesParams fetchProductsParams);
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  MoviesRemoteDataSourceImpl(this.service);

  final LinkToOutSideWorld service;

  @override
  Future<MoviesModel> getMovieList(FetchMoviesParams fetchProductsParams) async {
    return await service.request<MoviesModel>(
        url: ApiConstants.SEARCH_MOVIES,
        method: get,
        params: {'query': fetchProductsParams.query,
        'page':fetchProductsParams.page});
  }
}
