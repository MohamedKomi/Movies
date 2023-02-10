import 'package:dartz/dartz.dart';
import 'package:movies/tvs/domain/entities/tv.dart';
import 'package:movies/tvs/domain/entities/tv_details.dart';
import 'package:movies/tvs/domain/entities/tv_episodes.dart';
import 'package:movies/tvs/domain/entities/tv_recommendations.dart';

import '../../../core/error/failure.dart';
import '../usecase/get_tv_details_usecase.dart';
import '../usecase/get_tv_episodes_usecase.dart';
import '../usecase/get_tv_recommendations_usecase.dart';

abstract class BaseTvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTvs();

  Future<Either<Failure, List<Tv>>> getPopularTvs();

  Future<Either<Failure, List<Tv>>> getTopRatedTvs();

  Future<Either<Failure, TvDetails>> getTvDetail(
      TvDetailsParameters parameters);

  Future<Either<Failure, List<TvRecommendations>>> getTvRecommendations(
      TvRecommendationsParameters parameters);

  Future<Either<Failure, List<TvEpisodes>>> getTvEpisodes(
      TvEpisodesParameters parameters);
}
