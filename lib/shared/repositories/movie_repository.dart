import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:the_movies/core/errors/exceptions.dart';
import 'package:the_movies/core/helpers/global_helper.dart';
import 'package:the_movies/shared/models/movie.dart';

class MovieRepository {
  final Dio dio;

  MovieRepository(this.dio);

  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    try {
      var response = await dio.get('movie/top_rated?page=$page&region=ID');

      if (!AppGlobalHelper.isEmptyList(response.data['results'])) {
        return (response.data['results'] as List)
            .map((x) => Movie.fromJson(x))
            .toList();
      } else {
        return [];
      }
    } on DioException catch(e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch(e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }

  Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
    try {
      var response = await dio.get('movie/upcoming?page=$page&region=ID');

      if (!AppGlobalHelper.isEmptyList(response.data['results'])) {
        return (response.data['results'] as List)
            .map((x) => Movie.fromJson(x))
            .toList();
      } else {
        return [];
      }
    } on DioException catch(e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch(e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }

  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    try {
      var response = await dio.get('movie/now_playing?page=$page&region=ID');

      if (!AppGlobalHelper.isEmptyList(response.data['results'])) {
        return (response.data['results'] as List)
            .map((x) => Movie.fromJson(x))
            .toList();
      } else {
        return [];
      }
    } on DioException catch(e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch(e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }

  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      var response = await dio.get('movie/popular?page=$page&region=ID');

      if (!AppGlobalHelper.isEmptyList(response.data['results'])) {
        return (response.data['results'] as List)
            .map((x) => Movie.fromJson(x))
            .toList();
      } else {
        return [];
      }
    } on DioException catch(e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch(e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }

  Future<List<Movie>> getWatchlistMovies() async {
    try {
      var response = await dio.get('account/9766335/watchlist/movies');

      if (!AppGlobalHelper.isEmptyList(response.data['results'])) {
        return (response.data['results'] as List)
            .map((x) => Movie.fromJson(x))
            .toList();
      } else {
        return [];
      }
    } on DioException catch(e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch(e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }

  Future<bool> addWatchlistMovie(int id) async {
    try {
      var param = {'media_type': 'movie', 'media_id': id, 'watchlist': true};
      var response = await dio.post(
        'account/9766335/watchlist',
        data: jsonEncode(param),
      );

      return response.data['success'];
    } on DioException catch(e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch(e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }

  Future<List<Movie>> getSearchMovies({String query = ''}) async {
    try {
      var param = {
        'query': query,
        'include_adult': false,
        'region': 'ID',
        'page': 1
      };
      var response = await dio.get(
        'search/movie',
        queryParameters: param,
      );

      if (!AppGlobalHelper.isEmptyList(response.data['results'])) {
        return (response.data['results'] as List)
            .map((x) => Movie.fromJson(x))
            .toList();
      } else {
        return [];
      }
    } on DioException catch(e) {
      log(e.message ?? e.stackTrace.toString());
      throw NetworkException(message: e.message);
    } on FormatException catch(e) {
      log(e.message);
      throw AppException(message: e.message);
    }
  }
}
