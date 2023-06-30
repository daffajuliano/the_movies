import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:the_movies/core/errors/exceptions.dart';
import 'package:the_movies/core/helpers/global_helper.dart';
import 'package:the_movies/shared/models/tv_series.dart';

class TvShowRepository {
  final Dio dio;

  TvShowRepository(this.dio);

  Future<List<TvSeries>> getPopularTvShow({int page = 1}) async {
    try {
      var response = await dio.get('tv/popular?page=$page&region=ID');

      if (!AppGlobalHelper.isEmptyList(response.data['results'])) {
        return (response.data['results'] as List)
            .map((x) => TvSeries.fromJson(x))
            .toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch (e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }

  Future<List<TvSeries>> getTopRatedTvShow({int page = 1}) async {
    try {
      var response = await dio.get('tv/top_rated?page=$page&region=ID');

      if (!AppGlobalHelper.isEmptyList(response.data['results'])) {
        return (response.data['results'] as List)
            .map((x) => TvSeries.fromJson(x))
            .toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch (e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }

  Future<List<TvSeries>> getOnTheAirTvShow({int page = 1}) async {
    try {
      var response = await dio.get('tv/on_the_air?page=$page&region=ID');

      if (!AppGlobalHelper.isEmptyList(response.data['results'])) {
        return (response.data['results'] as List)
            .map((x) => TvSeries.fromJson(x))
            .toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch (e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }

  Future<List<TvSeries>> getAiringTvShow({int page = 1}) async {
    try {
      var response = await dio.get('tv/airing_today?page=$page&region=ID');

      if (!AppGlobalHelper.isEmptyList(response.data['results'])) {
        return (response.data['results'] as List)
            .map((x) => TvSeries.fromJson(x))
            .toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch (e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }

  Future<List<TvSeries>> getWatchlistTvShow() async {
    try {
      var response = await dio.get('account/9766335/watchlist/tv');

      if (!AppGlobalHelper.isEmptyList(response.data['results'])) {
        return (response.data['results'] as List)
            .map((x) => TvSeries.fromJson(x))
            .toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch (e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }

  Future<bool> addWatchlistTvShow(int id) async {
    try {
      var param = {'media_type': 'tv', 'media_id': id, 'watchlist': true};
      var response = await dio.post(
        'account/9766335/watchlist',
        data: jsonEncode(param),
      );

      return response.data['success'];
    } on DioException catch (e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch (e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }

  Future<List<TvSeries>> getSearchTvShows({String query = ''}) async {
    try {
      var param = {
        'query': query,
        'include_adult': false,
        'region': 'ID',
        'page': 1
      };
      var response = await dio.get(
        'search/tv',
        queryParameters: param,
      );

      if (!AppGlobalHelper.isEmptyList(response.data['results'])) {
        return (response.data['results'] as List)
            .map((x) => TvSeries.fromJson(x))
            .toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch (e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }
}
