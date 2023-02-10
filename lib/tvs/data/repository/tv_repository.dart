import 'package:dartz/dartz.dart';
import 'package:movies/core/error/exceptions.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/tvs/data/data_source/tv_remote_data_source.dart';
import 'package:movies/tvs/domain/entities/tv.dart';
import 'package:movies/tvs/domain/entities/tv_details.dart';
import 'package:movies/tvs/domain/entities/tv_episodes.dart';
import 'package:movies/tvs/domain/entities/tv_recommendations.dart';
import 'package:movies/tvs/domain/repository/base_tv_repository.dart';
import 'package:movies/tvs/domain/usecase/get_tv_details_usecase.dart';
import 'package:movies/tvs/domain/usecase/get_tv_episodes_usecase.dart';
import 'package:movies/tvs/domain/usecase/get_tv_recommendations_usecase.dart';

class TvRepository extends BaseTvRepository {
  final BaseTvsRemoteDataSource tvsRemoteDataSource;

  TvRepository(this.tvsRemoteDataSource);

  @override
  Future<Either<Failure, List<Tv>>> getOnTheAirTvs() async {
    final result = await tvsRemoteDataSource.getOnTheAirTvs();

    try {
      return right(result);
    } on ServerExceptions catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTvs() async {
    final result = await tvsRemoteDataSource.getPopularTvs();

    try {
      return right(result);
    } on ServerExceptions catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTvs() async {
    final result = await tvsRemoteDataSource.getTopRatedTvs();
    try {
      return right(result);
    } on ServerExceptions catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, TvDetails>> getTvDetail(
      TvDetailsParameters parameters) async {
    final result = await tvsRemoteDataSource.getTvDetails(parameters);
    try {
      return right(result);
    } on ServerExceptions catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<TvRecommendations>>> getTvRecommendations(
      TvRecommendationsParameters parameters) async {
    final result = await tvsRemoteDataSource.getTvRecommendations(parameters);
    try {
      return right(result);
    } on ServerExceptions catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<TvEpisodes>>> getTvEpisodes(
      TvEpisodesParameters parameters) async {
    final result = await tvsRemoteDataSource.getTvEpisodes(parameters);
    try {
      return right(result);
    } on ServerExceptions catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
