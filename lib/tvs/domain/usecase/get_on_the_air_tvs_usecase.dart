import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/tvs/domain/entities/tv.dart';
import 'package:movies/tvs/domain/repository/base_tv_repository.dart';

class GetOnTheAirTvsUseCase extends BaseUseCase<List<Tv>, NoParameters> {
  final BaseTvRepository baseTvRepository;

  GetOnTheAirTvsUseCase(this.baseTvRepository);

  @override
  Future<Either<Failure, List<Tv>>> call(NoParameters parameters) {
    return baseTvRepository.getOnTheAirTvs();
  }
}
