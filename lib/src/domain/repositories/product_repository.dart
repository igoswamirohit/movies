import '../../data/models/movie_model.dart';
import '../usecases/movies_usecase.dart';

abstract class MoviesRepository {
  Future<MoviesModel> getMovies(FetchMoviesParams moviesParam);
}
