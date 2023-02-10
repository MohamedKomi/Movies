import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/core/utils/request_states.dart';

import 'package:movies/movies/domain/usecase/get_now_playing_movies_usecase.dart';
import 'package:movies/movies/presentation/controller/movies_events.dart';
import 'package:movies/movies/presentation/controller/movies_states.dart';

import '../../domain/usecase/get_popular_movies_usecase.dart';
import '../../domain/usecase/get_top_rated_movies_usecase.dart';

class MoviesBloc extends Bloc<MoviesEvents, MoviesStates> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  MoviesBloc(this.getNowPlayingMoviesUseCase, this.getPopularMoviesUseCase,
      this.getTopRatedMoviesUseCase)
      : super(const MoviesStates()) {
    on<GetNowPlayingMoviesEvents>(_getNowPlayingMovies);
    on<GetPopularMoviesEvents>(_getPopularMovies);
    on<GetTopRatedMoviesEvents>(_getTopRatedMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvents event, Emitter<MoviesStates> emit) async {
    final result = await getNowPlayingMoviesUseCase(const NoParameters());

    result.fold(
      (l) => emit(state.copyWith(
        nowPlayingState: RequestState.error,
        nowPlayingMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(
            nowPlayingState: RequestState.loaded, nowPlayingMovies: r),
      ),
    );
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvents event, Emitter<MoviesStates> emit) async {
    final result = await getPopularMoviesUseCase(const NoParameters());

    result.fold(
      (l) => emit(state.copyWith(
        popularState: RequestState.error,
        popularMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(popularState: RequestState.loaded, popularMovies: r),
      ),
    );
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvents event, Emitter<MoviesStates> emit) async {
    final result = await getTopRatedMoviesUseCase(const NoParameters());
    result.fold(
      (l) => emit(state.copyWith(
          topRatedState: RequestState.error, topRatedMessage: l.message)),
      (r) => emit(
        state.copyWith(topRatedState: RequestState.loaded, topRatedMovies: r),
      ),
    );
  }
}
