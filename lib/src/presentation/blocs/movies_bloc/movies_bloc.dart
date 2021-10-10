import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/movies_usecase.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc(this.moviesUseCase) : super(MoviesInitial()) {
    on<MoviesRequested>((event, emit) async {
      try {
        emit(_mapPageToState(page));
        final movieModel =
            await moviesUseCase(FetchMoviesParams(event.query, page));
        emit(MoviesFetchSuccess(movieModel.results));
        totalPages = movieModel.totalPages;
        page++;
      } on Exception catch (e) {
        emit(MoviesFetchFailure(e));
      }
    });
  }

  final FetchMoviesUseCase moviesUseCase;
  int page = 1;
  int totalPages = 0;
  bool isFetching = false;

  MoviesState _mapPageToState(int page) {
    return page == 0 ? MoviesFetchProgress() : MoviesFurtherFetchProgress();
  }
}
