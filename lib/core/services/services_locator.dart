import 'package:get_it/get_it.dart';
import 'package:movies/movies/data/data_source/movie_remote_data_source.dart';
import 'package:movies/movies/data/repository/movies_repository.dart';
import 'package:movies/movies/domain/repository/base_movies_repository.dart';
import 'package:movies/movies/domain/usecase/get_movie_detail_usecase.dart';
import 'package:movies/movies/domain/usecase/get_now_playing_movies_usecase.dart';
import 'package:movies/movies/domain/usecase/get_recommendations_usecase.dart';
import 'package:movies/movies/presentation/controller/movie_details_bloc.dart';
import 'package:movies/movies/presentation/controller/movies_bloc.dart';
import 'package:movies/tvs/data/data_source/tv_remote_data_source.dart';
import 'package:movies/tvs/data/repository/tv_repository.dart';
import 'package:movies/tvs/domain/repository/base_tv_repository.dart';
import 'package:movies/tvs/domain/usecase/get_on_the_air_tvs_usecase.dart';
import 'package:movies/tvs/domain/usecase/get_popular_tvs_usecase.dart';
import 'package:movies/tvs/domain/usecase/get_top_rated_tvs_usecase.dart';
import 'package:movies/tvs/domain/usecase/get_tv_details_usecase.dart';
import 'package:movies/tvs/domain/usecase/get_tv_episodes_usecase.dart';
import 'package:movies/tvs/domain/usecase/get_tv_recommendations_usecase.dart';
import 'package:movies/tvs/presentation/controller/tv_details_bloc.dart';
import 'package:movies/tvs/presentation/controller/tvs_bloc.dart';

import '../../movies/domain/usecase/get_popular_movies_usecase.dart';
import '../../movies/domain/usecase/get_top_rated_movies_usecase.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    ///MOVIE BLOCS
    sl.registerFactory(() => MoviesBloc(sl(), sl(), sl()));
    sl.registerFactory(() => MovieDetailsBloc(sl(), sl()));

    ///MOVIE USE CASES
    sl.registerLazySingleton(() => GetNowPlayingMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieDetailUseCase(sl()));
    sl.registerLazySingleton(() => GetRecommendationsUseCase(sl()));

    ///MOVIE REPOSITORY
    sl.registerLazySingleton<BaseMoviesRepository>(
        () => MoviesRepository(sl()));

    ///MOVIE DATA SOURCE
    sl.registerLazySingleton<BaseMoviesRemoteDataSource>(
        () => MovieRemoteDataSource());

    /// TV BLOCS
    sl.registerFactory(() => TvsBloc(sl(), sl(), sl()));
    sl.registerFactory(() => TvDetailsBloc(sl(),sl(),sl()));

    ///TV USE CASES
    sl.registerLazySingleton(() => GetOnTheAirTvsUseCase(sl()));
    sl.registerLazySingleton(() => GetPopularTvsUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedTvsUseCase(sl()));
    sl.registerLazySingleton(() => GetTvDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetTvRecommendationsUseCase(sl()));
    sl.registerLazySingleton(() => GetTvEpisodesUseCase(sl()));



    /// TV REPOSITORY
    sl.registerLazySingleton<BaseTvRepository>(() => TvRepository(sl()));

    ///TV DATE SOURCE
    sl.registerLazySingleton<BaseTvsRemoteDataSource>(
        () => TvsRemoteDataSource());
  }
}
