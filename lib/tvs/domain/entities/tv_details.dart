import 'package:equatable/equatable.dart';
import 'package:movies/tvs/domain/entities/tv_genres.dart';

class TvDetails extends Equatable {
  final String backdropPath;
  final int id;
  final List<TvGenres> genres;
  final String overview;
  final String airDate;
  final int runtime;
  final String name;
  final double voteAverage;
  final int numberOfSeasons;


  const TvDetails(
      {required this.backdropPath,
      required this.id,
      required this.genres,
      required this.overview,
      required this.airDate,
      required this.runtime,
      required this.name,
      required this.voteAverage,
      required this.numberOfSeasons});

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        genres,
        overview,
        airDate,
        runtime,
        name,
        voteAverage,
        numberOfSeasons,
      ];
}
