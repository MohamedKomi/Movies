import 'package:equatable/equatable.dart';
import 'package:movies/core/utils/request_states.dart';
import 'package:movies/tvs/domain/entities/tv_episodes.dart';
import 'package:movies/tvs/domain/entities/tv_recommendations.dart';

import '../../domain/entities/tv_details.dart';

class TvDetailsStates extends Equatable {
  final TvDetails? tvDetails;
  final RequestState tvDetailsState;
  final String tvDetailsMessage;
  final List<TvRecommendations> tvRecommendations;
  final RequestState tvRecommendationsState;
  final String tvRecommendationsMessage;
  final List<TvEpisodes> tvEpisodes;
  final RequestState tvEpisodesState;
  final String tvEpisodesMessage;

  const TvDetailsStates(
      {this.tvDetails,
      this.tvDetailsState = RequestState.loading,
      this.tvDetailsMessage = '',
      this.tvRecommendations = const [],
      this.tvRecommendationsState = RequestState.loading,
      this.tvRecommendationsMessage = '',
      this.tvEpisodes = const [],
      this.tvEpisodesState = RequestState.loading,
      this.tvEpisodesMessage = ''});

  TvDetailsStates copyWith(
      {TvDetails? tvDetails,
      RequestState? tvDetailsState,
      String? tvDetailsMessage,
      List<TvRecommendations>? tvRecommendations,
      RequestState? tvRecommendationsState,
      String? tvRecommendationsMessage,
      List<TvEpisodes>? tvEpisodes,
      RequestState? tvEpisodesState,
      String? tvEpisodesMessage}) {
    return TvDetailsStates(
      tvDetails: tvDetails ?? this.tvDetails,
      tvDetailsState: tvDetailsState ?? this.tvDetailsState,
      tvDetailsMessage: tvDetailsMessage ?? this.tvDetailsMessage,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      tvRecommendationsState:
          tvRecommendationsState ?? this.tvRecommendationsState,
      tvRecommendationsMessage:
          tvRecommendationsMessage ?? this.tvRecommendationsMessage,
      tvEpisodes: tvEpisodes ?? this.tvEpisodes,
      tvEpisodesState: tvEpisodesState ?? this.tvEpisodesState,
      tvEpisodesMessage: tvEpisodesMessage ?? this.tvEpisodesMessage,
    );
  }

  @override
  List<Object?> get props => [
        tvDetails,
        tvDetailsState,
        tvDetailsMessage,
        tvRecommendations,
        tvRecommendationsState,
        tvRecommendationsMessage,
        tvEpisodes,
        tvEpisodesState,
        tvEpisodesMessage
      ];
}
