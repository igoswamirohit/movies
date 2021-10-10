part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesFetchProgress extends MoviesState {}

class MoviesFurtherFetchProgress extends MoviesState {}

class MoviesFetchSuccess extends MoviesState {

  const MoviesFetchSuccess(this.movies);

  final List<Movie> movies;
}

class MoviesFetchFailure extends MoviesState {
  final exception;

  const MoviesFetchFailure(this.exception);
}
