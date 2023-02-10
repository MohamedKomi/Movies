import 'package:equatable/equatable.dart';

abstract class TvDetailsEvents extends Equatable {
  const TvDetailsEvents();
}

class GetTvDetailsEvents extends TvDetailsEvents {
  final int id;

  const GetTvDetailsEvents(this.id);

  @override
  List<Object?> get props => [id];
}

class GetTvRecommendationsEvents extends TvDetailsEvents {
  final int id;

  const GetTvRecommendationsEvents(this.id);

  @override
  List<Object?> get props => [id];
}

class GetTvEpisodesEvents extends TvDetailsEvents {
  final int id;
  final int seasonNumber;

  const GetTvEpisodesEvents(this.id, this.seasonNumber);

  @override
  List<Object?> get props => [
        id,
        seasonNumber,
      ];
}
