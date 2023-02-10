import 'package:movies/movies/data/model/movie_genres_model.dart';
import 'package:movies/movies/domain/entities/movie_details.dart';

class MovieDetailModel extends MovieDetails {
  const MovieDetailModel({
    required super.backdropPath,
    required super.id,
    required super.genres,
    required super.overview,
    required super.releaseDate,
    required super.runtime,
    required super.title,
    required super.voteAverage,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        genres: List<MovieGenresModel>.from(json["genres"]
            .map((e) => MovieGenresModel.fromJson(e))),
        overview: json["overview"],
        releaseDate: json["release_date"],
        runtime: json["runtime"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
      );
}
