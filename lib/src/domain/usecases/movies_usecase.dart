
import '../../core/usecases/usecase.dart';
import '../../data/models/movie_model.dart';
import '../repositories/product_repository.dart';

class FetchMoviesUseCase implements UseCase<MoviesModel, FetchMoviesParams> {
  final MoviesRepository repository;

  FetchMoviesUseCase(this.repository);

  @override
  Future<MoviesModel> call(FetchMoviesParams fetchProductsParams) async {
    return await repository.getMovies(fetchProductsParams);
  }
}

class FetchMoviesParams {
  final String query;
  final int page;

  FetchMoviesParams(this.query, this.page);
}
