import 'package:equatable/equatable.dart';

abstract class MoviesEvents extends Equatable {
  const MoviesEvents();

  @override
  List<Object> get props => [];
}

class GetNowPlayingMoviesEvents extends MoviesEvents {}

class GetPopularMoviesEvents extends MoviesEvents {}

class GetTopRatedMoviesEvents extends MoviesEvents {}
