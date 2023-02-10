import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/core/utils/request_states.dart';
import 'package:movies/tvs/domain/usecase/get_on_the_air_tvs_usecase.dart';
import 'package:movies/tvs/domain/usecase/get_popular_tvs_usecase.dart';
import 'package:movies/tvs/domain/usecase/get_top_rated_tvs_usecase.dart';
import 'package:movies/tvs/presentation/controller/tvs_events.dart';
import 'package:movies/tvs/presentation/controller/tvs_states.dart';

class TvsBloc extends Bloc<TvsEvents, TvsStates> {
  final GetOnTheAirTvsUseCase getOnTheAirTvsUseCase;
  final GetPopularTvsUseCase getPopularTvsUseCase;
  final GetTopRatedTvsUseCase getTopRatedTvsUseCase;

  TvsBloc(this.getOnTheAirTvsUseCase, this.getPopularTvsUseCase,
      this.getTopRatedTvsUseCase)
      : super(const TvsStates()) {
    on<GetOnTheAirTvsEvents>(_getOnTheAirTvs);
    on<GetPopularTvsEvents>(_getPopularTvs);
    on<GetTopRatedTvsEvents>(_getTopRatedTvs);
  }

  FutureOr<void> _getOnTheAirTvs(
      GetOnTheAirTvsEvents event, Emitter<TvsStates> emit) async {
    final result = await getOnTheAirTvsUseCase(const NoParameters());
    result.fold(
      (l) => emit(state.copyWith(
        onTheAirTvsState: RequestState.error,
        onTheAirTvsMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(onTheAirTvsState: RequestState.loaded, onTheAirTvs: r),
      ),
    );
  }

  FutureOr<void> _getPopularTvs(
      GetPopularTvsEvents event, Emitter<TvsStates> emit) async {
    final result = await getPopularTvsUseCase(const NoParameters());
    result.fold(
      (l) => emit(state.copyWith(
        popularTvsState: RequestState.error,
        popularTvsMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(
          popularTvsState: RequestState.loaded,
          popularTvs: r,
        ),
      ),
    );
  }

  FutureOr<void> _getTopRatedTvs(
      GetTopRatedTvsEvents event, Emitter<TvsStates> emit) async {
    final result = await getTopRatedTvsUseCase(const NoParameters());
    result.fold(
      (l) => emit(state.copyWith(
        topRatedTvsState: RequestState.error,
        topRatedTvsMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(topRatedTvsState: RequestState.loaded, topRatedTvs: r),
      ),
    );
  }
}
