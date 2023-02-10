import 'package:movies/tvs/domain/entities/tv_episodes.dart';

class TvEpisodesModel extends TvEpisodes {
  const TvEpisodesModel({
    required super.stillPath,
    required super.airDate,
    required super.overView,
    required super.episodeNumber,
    required super.name,
  });

  factory TvEpisodesModel.fromJson(Map<String, dynamic> json) =>
      TvEpisodesModel(
        stillPath: json['still_path']??'/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',
        airDate: json['air_date']??'0',
        overView: json['overview'],
        episodeNumber: json['episode_number'],
        name: json['name'],
      );
}
