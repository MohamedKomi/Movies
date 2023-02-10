import 'package:movies/core/error/exceptions.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/movies/data/data_source/movie_remote_data_source.dart';
import 'package:movies/movies/domain/entities/movie.dart';
import 'package:movies/movies/domain/entities/movie_details.dart';
import 'package:movies/movies/domain/entities/movie_recommendation.dart';
import 'package:movies/movies/domain/repository/base_movies_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/movies/domain/usecase/get_recommendations_usecase.dart';

import '../../domain/usecase/get_movie_detail_usecase.dart';

class MoviesRepository extends BaseMoviesRepository {
  final BaseMoviesRemoteDataSource moviesRemoteDataSource;

  MoviesRepository(this.moviesRemoteDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    final result = await moviesRemoteDataSource.getNowPlayingMovies();
    try {
      return right(result);
    } on ServerExceptions catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    final result = await moviesRemoteDataSource.getPopularMovies();
    try {
      return right(result);
    } on ServerExceptions catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    final result = await moviesRemoteDataSource.getTopRatedMovies();
    try {
      return right(result);
    } on ServerExceptions catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetail(
      MovieDetailsParameters parameters) async {
    final result = await moviesRemoteDataSource.getMovieDetails(parameters);
    try {
      return right(result);
    } on ServerExceptions catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<MovieRecommendation>>> getRecommendations(
      MovieRecommendationsParameters parameters) async {
    final result = await moviesRemoteDataSource.getRecommendations(parameters);
    try {
      return right(result);
    } on ServerExceptions catch (failure) {
      return left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
