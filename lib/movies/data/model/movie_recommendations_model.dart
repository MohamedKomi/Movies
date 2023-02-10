import 'package:movies/movies/domain/entities/movie_recommendation.dart';

class MovieRecommendationsModel extends MovieRecommendation {
  const MovieRecommendationsModel({
    required super.id,
     super.backdropPath,
  });

  factory MovieRecommendationsModel.fromJson(Map<String, dynamic> json) =>
      MovieRecommendationsModel(
        id: json["id"],
        backdropPath: json["backdrop_path"]??'/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',
      );
}
