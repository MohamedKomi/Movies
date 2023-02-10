import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/tvs/domain/entities/tv_recommendations.dart';
import 'package:movies/tvs/domain/repository/base_tv_repository.dart';

class GetTvRecommendationsUseCase
    extends BaseUseCase<List<TvRecommendations>, TvRecommendationsParameters> {
  final BaseTvRepository baseTvRepository;

  GetTvRecommendationsUseCase(this.baseTvRepository);

  @override
  Future<Either<Failure, List<TvRecommendations>>> call(
      TvRecommendationsParameters parameters) async {
    return await baseTvRepository.getTvRecommendations(parameters);
  }
}

class TvRecommendationsParameters extends Equatable {
  final int tvId;

  const TvRecommendationsParameters(this.tvId);

  @override
  List<Object?> get props => [tvId];
}
