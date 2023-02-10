import 'package:movies/tvs/data/model/tv_genres_model.dart';
import 'package:movies/tvs/domain/entities/tv_details.dart';

class TvDetailModel extends TvDetails {
  const TvDetailModel(
      {required super.backdropPath,
      required super.id,
      required super.genres,
      required super.overview,
      required super.airDate,
      required super.runtime,
      required super.name,
      required super.voteAverage,
      required super.numberOfSeasons});

  factory TvDetailModel.fromJson(Map<String, dynamic> json) => TvDetailModel(
        backdropPath: json['backdrop_path']??'/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',
        id: json['id'],
        genres: List<TvGenresModel>.from(
            json["genres"].map((e) => TvGenresModel.fromJson(e))),
        overview: json['overview'],
        airDate: json['first_air_date'],
        runtime: json['last_episode_to_air']['runtime']?? 0,
        name: json['name'],
        voteAverage: json['vote_average'],
        numberOfSeasons: json['number_of_seasons'],
      );
}
