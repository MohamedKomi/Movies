import 'package:movies/movies/domain/entities/movie_genres.dart';

class MovieGenresModel extends MovieGenres {
  const MovieGenresModel({
    required super.name,
    required super.id,
  });

  factory MovieGenresModel.fromJson(Map<String, dynamic> json) => MovieGenresModel(
        name: json["name"],
        id: json["id"],
      );
}
