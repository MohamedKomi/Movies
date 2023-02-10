import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/movies/domain/entities/movie.dart';
import 'package:movies/movies/domain/entities/movie_details.dart';
import 'package:movies/movies/domain/entities/movie_recommendation.dart';
import 'package:movies/movies/domain/usecase/get_movie_detail_usecase.dart';
import 'package:movies/movies/domain/usecase/get_recommendations_usecase.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, MovieDetails>> getMovieDetail(
      MovieDetailsParameters parameters);

  Future<Either<Failure, List<MovieRecommendation>>> getRecommendations(
      MovieRecommendationsParameters parameters);
}
