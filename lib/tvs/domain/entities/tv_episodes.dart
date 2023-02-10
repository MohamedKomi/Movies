import 'package:equatable/equatable.dart';

class TvEpisodes extends Equatable {
  final String stillPath;

  final String airDate;
  final String overView;
  final int episodeNumber;
  final String name;

  const TvEpisodes({
    required this.stillPath,
    required this.airDate,
    required this.overView,
    required this.episodeNumber,
    required this.name,
  });

  @override
  List<Object?> get props => [
        stillPath,
        airDate,
        overView,
        name,
        episodeNumber,
      ];
}
