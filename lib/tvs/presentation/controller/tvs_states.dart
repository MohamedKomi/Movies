import 'package:equatable/equatable.dart';
import 'package:movies/core/utils/request_states.dart';

import '../../domain/entities/tv.dart';

class TvsStates extends Equatable {
  final List<Tv> onTheAirTvs;
  final RequestState onTheAirTvsState;
  final String onTheAirTvsMessage;
  final List<Tv> popularTvs;
  final RequestState popularTvsState;
  final String popularTvsMessage;
  final List<Tv> topRatedTvs;
  final RequestState topRatedTvsState;
  final String topRatedTvsMessage;

  const TvsStates({
    this.onTheAirTvs = const [],
    this.onTheAirTvsState = RequestState.loading,
    this.onTheAirTvsMessage = '',
    this.popularTvs = const [],
    this.popularTvsState = RequestState.loading,
    this.popularTvsMessage = '',
    this.topRatedTvs = const [],
    this.topRatedTvsState = RequestState.loading,
    this.topRatedTvsMessage = '',
  });

  TvsStates copyWith({
    List<Tv>? onTheAirTvs,
    RequestState? onTheAirTvsState,
    String? onTheAirTvsMessage,
    List<Tv>? popularTvs,
    RequestState? popularTvsState,
    String? popularTvsMessage,
    List<Tv>? topRatedTvs,
    RequestState? topRatedTvsState,
    String? topRatedTvsMessage,
  }) {
    return TvsStates(
      onTheAirTvs: onTheAirTvs ?? this.onTheAirTvs,
      onTheAirTvsState: onTheAirTvsState ?? this.onTheAirTvsState,
      onTheAirTvsMessage: onTheAirTvsMessage ?? this.onTheAirTvsMessage,
      popularTvs: popularTvs ?? this.popularTvs,
      popularTvsState: popularTvsState ?? this.popularTvsState,
      popularTvsMessage: popularTvsMessage ?? this.popularTvsMessage,
      topRatedTvs: topRatedTvs ?? this.topRatedTvs,
      topRatedTvsState: topRatedTvsState ?? this.topRatedTvsState,
      topRatedTvsMessage: topRatedTvsMessage ?? this.topRatedTvsMessage,
    );
  }

  @override
  List<Object?> get props => [
        onTheAirTvs,
        onTheAirTvsState,
        onTheAirTvsMessage,
        popularTvs,
        popularTvsState,
        popularTvsMessage,
        topRatedTvs,
        topRatedTvsMessage,
        topRatedTvsState,
      ];
}
