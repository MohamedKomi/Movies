import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/tvs/domain/entities/tv_episodes.dart';
import 'package:movies/tvs/domain/repository/base_tv_repository.dart';

class GetTvEpisodesUseCase extends BaseUseCase<List<TvEpisodes>, TvEpisodesParameters> {
  final BaseTvRepository baseTvRepository;

  GetTvEpisodesUseCase(this.baseTvRepository);

  @override
  Future<Either<Failure, List<TvEpisodes>>> call(
      TvEpisodesParameters parameters) async {
    return await baseTvRepository.getTvEpisodes(parameters);
  }
}

class TvEpisodesParameters extends Equatable {
  final int tvId;
  final int seasonNumber;


  const TvEpisodesParameters(this.seasonNumber,this.tvId);

  @override
  List<Object?> get props => [seasonNumber];
}
