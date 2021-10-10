part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}


class MoviesRequested extends MoviesEvent {
  final String query;
  const MoviesRequested(this.query);
}
