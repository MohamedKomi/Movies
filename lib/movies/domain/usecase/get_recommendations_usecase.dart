import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/movies/domain/entities/movie_recommendation.dart';
import 'package:movies/movies/domain/repository/base_movies_repository.dart';

class GetRecommendationsUseCase
    extends BaseUseCase<List<MovieRecommendation>, MovieRecommendationsParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetRecommendationsUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<MovieRecommendation>>> call(
      MovieRecommendationsParameters parameters) async {
    return await baseMoviesRepository.getRecommendations(parameters);
  }
}

class MovieRecommendationsParameters extends Equatable {
  final int id;

  const MovieRecommendationsParameters(this.id);

  @override
  List<Object> get props => [id];
}
