import 'package:movies/tvs/domain/entities/tv_recommendations.dart';

class TvRecommendationsModel extends TvRecommendations {
  const TvRecommendationsModel({
    required super.id,
    super.backdropPath,
  });

  factory TvRecommendationsModel.fromJson(Map<String, dynamic> json) =>
      TvRecommendationsModel(
        id: json['id'],
        backdropPath:
            json['backdrop_path'] ?? '/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',
      );
}
