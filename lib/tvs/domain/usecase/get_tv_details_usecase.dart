import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/tvs/domain/entities/tv_details.dart';
import 'package:movies/tvs/domain/repository/base_tv_repository.dart';

class GetTvDetailsUseCase extends BaseUseCase<TvDetails, TvDetailsParameters> {
  final BaseTvRepository baseTvRepository;

  GetTvDetailsUseCase(this.baseTvRepository);

  @override
  Future<Either<Failure, TvDetails>> call(
      TvDetailsParameters parameters) async {
    return await baseTvRepository.getTvDetail(parameters);
  }
}

class TvDetailsParameters extends Equatable {
  final int tvId;

  const TvDetailsParameters(this.tvId);

  @override
  List<Object?> get props => [tvId];
}
