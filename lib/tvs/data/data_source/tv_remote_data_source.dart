import 'package:dio/dio.dart';
import 'package:movies/core/network/api_constances.dart';
import 'package:movies/tvs/data/model/tv_detail_model.dart';
import 'package:movies/tvs/data/model/tv_model.dart';
import 'package:movies/tvs/data/model/tv_recommendations_model.dart';
import 'package:movies/tvs/domain/entities/tv_episodes.dart';
import 'package:movies/tvs/domain/usecase/get_tv_details_usecase.dart';
import 'package:movies/tvs/domain/usecase/get_tv_recommendations_usecase.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/network/error_message_model.dart';
import '../../domain/usecase/get_tv_episodes_usecase.dart';
import '../model/tv_episodes_model.dart';

abstract class BaseTvsRemoteDataSource {
  Future<List<TvModel>> getOnTheAirTvs();

  Future<List<TvModel>> getPopularTvs();

  Future<List<TvModel>> getTopRatedTvs();

  Future<TvDetailModel> getTvDetails(TvDetailsParameters parameters);

  Future<List<TvRecommendationsModel>> getTvRecommendations(
      TvRecommendationsParameters parameters);

  Future<List<TvEpisodes>> getTvEpisodes(TvEpisodesParameters parameters);
}

class TvsRemoteDataSource extends BaseTvsRemoteDataSource {
  @override
  Future<List<TvModel>> getOnTheAirTvs() async {
    final response = await Dio().get(ApiConstance.onTheAirTvsPath);
    if (response.statusCode == 200) {
      return List<TvModel>.from(
          (response.data['results'] as List).map((e) => TvModel.fromJson(e)));
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<TvModel>> getPopularTvs() async {
    final response = await Dio().get(ApiConstance.popularTvsPath);

    if (response.statusCode == 200) {
      return List<TvModel>.from(
          (response.data['results'] as List).map((e) => TvModel.fromJson(e)));
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvs() async {
    final response = await Dio().get(ApiConstance.topRatedTvsPath);
    if (response.statusCode == 200) {
      return List<TvModel>.from(
          (response.data['results'] as List).map((e) => TvModel.fromJson(e)));
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<TvDetailModel> getTvDetails(TvDetailsParameters parameters) async {
    final response =
        await Dio().get(ApiConstance.tvDetailsPath(parameters.tvId));

    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(response.data);
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<TvRecommendationsModel>> getTvRecommendations(
      TvRecommendationsParameters parameters) async {
    final response =
        await Dio().get(ApiConstance.tvRecommendationsPath(parameters.tvId));
    if (response.statusCode == 200) {
      return List<TvRecommendationsModel>.from(
          (response.data['results'] as List)
              .map((e) => TvRecommendationsModel.fromJson(e)));
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<TvEpisodes>> getTvEpisodes(
      TvEpisodesParameters parameters) async {
    final response = await Dio().get(
        ApiConstance.tvSeasonPath(parameters.tvId, parameters.seasonNumber));
    if (response.statusCode == 200) {
      return List<TvEpisodes>.from((response.data['episodes'] as List)
          .map((e) => TvEpisodesModel.fromJson(e)));
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
