import 'package:movies/tvs/domain/entities/tv_genres.dart';

class TvGenresModel extends TvGenres {
  const TvGenresModel({
    required super.name,
    required super.id,
  });

  factory TvGenresModel.fromJson(Map<String, dynamic> json) => TvGenresModel(
        name: json["name"],
        id: json["id"],
      );
}
