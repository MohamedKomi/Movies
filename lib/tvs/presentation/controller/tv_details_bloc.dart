import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/utils/request_states.dart';
import 'package:movies/tvs/presentation/controller/tv_details_events.dart';
import 'package:movies/tvs/presentation/controller/tv_details_states.dart';

import '../../domain/usecase/get_tv_details_usecase.dart';
import '../../domain/usecase/get_tv_episodes_usecase.dart';
import '../../domain/usecase/get_tv_recommendations_usecase.dart';

class TvDetailsBloc extends Bloc<TvDetailsEvents, TvDetailsStates> {
  final GetTvDetailsUseCase getTvDetailsUseCase;
  final GetTvRecommendationsUseCase getTvRecommendationsUseCase;
  final GetTvEpisodesUseCase getTvEpisodesUseCase;

  TvDetailsBloc(
    this.getTvDetailsUseCase,
    this.getTvRecommendationsUseCase,
    this.getTvEpisodesUseCase,
  ) : super(const TvDetailsStates()) {
    on<GetTvDetailsEvents>(_getTvDetails);
    on<GetTvRecommendationsEvents>(_getTvRecommendations);
    on<GetTvEpisodesEvents>(_getTvEpisodes);
  }

  FutureOr<void> _getTvDetails(
      GetTvDetailsEvents event, Emitter<TvDetailsStates> emit) async {
    final result = await getTvDetailsUseCase(TvDetailsParameters(event.id));
    result.fold(
      (l) => emit(
        state.copyWith(
          tvDetailsState: RequestState.error,
          tvDetailsMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          tvDetailsState: RequestState.loaded,
          tvDetails: r,
        ),
      ),
    );
  }

  FutureOr<void> _getTvRecommendations(
      GetTvRecommendationsEvents event, Emitter<TvDetailsStates> emit) async {
    final result = await getTvRecommendationsUseCase(
        TvRecommendationsParameters(event.id));
    result.fold(
      (l) => emit(state.copyWith(
        tvRecommendationsState: RequestState.error,
        tvRecommendationsMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(
          tvRecommendationsState: RequestState.loaded,
          tvRecommendations: r,
        ),
      ),
    );
  }

  FutureOr<void> _getTvEpisodes(

      GetTvEpisodesEvents event, Emitter<TvDetailsStates> emit) async {

    final result = await getTvEpisodesUseCase(
        TvEpisodesParameters(event.seasonNumber, event.id));
    result.fold(
      (l) => emit(state.copyWith(
          tvEpisodesState: RequestState.error, tvEpisodesMessage: l.message)),
      (r) => emit(
        state.copyWith(tvEpisodes: r, tvEpisodesState: RequestState.loaded),
      ),
    );
  }
}
