import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/core/errors/exceptions.dart';
import 'package:the_movies/core/helpers/global_helper.dart';
import 'package:the_movies/shared/models/movie.dart';
import 'package:the_movies/shared/repositories/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(MovieState()) {
    on<LoadAllMovieEvent>(_onLoadAllMovie);
    on<AddToWatchListMovieEvent>(_onAddToWatchlistMovie);
    on<SearchMovieEvent>(_onSearchMovie);
    on<ClearSearchMovieEvent>(_onClearSearchMovie);
  }

  FutureOr<void> _onLoadAllMovie(
      LoadAllMovieEvent event, Emitter<MovieState> emit) async {
    try {
      emit(state.copyWith(movieStatus: MovieStatus.loading));

      List<Movie> topRated = await movieRepository.getTopRatedMovies();
      List<Movie> upcoming = await movieRepository.getUpcomingMovies();
      List<Movie> nowPlaying = await movieRepository.getNowPlayingMovies();
      List<Movie> popular = await movieRepository.getPopularMovies();
      List<Movie> watchlist = await movieRepository.getWatchlistMovies();

      // check if movies has watchlist
      if (!AppGlobalHelper.isEmptyList(watchlist)) {
        for (var w in watchlist) {
          int topRatedIndex =
              topRated.indexWhere((element) => w.id == element.id);
          if (topRatedIndex >= 0) {
            topRated[topRatedIndex] =
                topRated[topRatedIndex].copyWith(watchList: true);
          }

          int upcomingIndex =
              upcoming.indexWhere((element) => w.id == element.id);
          if (upcomingIndex >= 0) {
            upcoming[upcomingIndex] =
                upcoming[upcomingIndex].copyWith(watchList: true);
          }

          int nowPlayingIndex =
              nowPlaying.indexWhere((element) => w.id == element.id);
          if (nowPlayingIndex >= 0) {
            nowPlaying[nowPlayingIndex] =
                nowPlaying[nowPlayingIndex].copyWith(watchList: true);
          }

          int popularIndex =
              popular.indexWhere((element) => w.id == element.id);
          if (popularIndex >= 0) {
            popular[popularIndex] =
                popular[popularIndex].copyWith(watchList: true);
          }
        }
      }

      emit(state.copyWith(
        movieStatus: MovieStatus.loaded,
        listTopRatedMovies: topRated,
        listUpcomingMovies: upcoming,
        listNowPlayingMovies: nowPlaying,
        listPopularMovies: popular,
        listWatchlistMovies: watchlist,
      ));

      emit(state.copyWith(movieStatus: MovieStatus.initial));
    } catch (e) {
      if (e is AppException) {
        emit(state.copyWith(
          movieStatus: MovieStatus.error,
          message: e.message,
        ));
      } else {
        emit(state.copyWith(
          movieStatus: MovieStatus.error,
          message: 'Something Wrong',
        ));
      }
    }
  }

  FutureOr<void> _onAddToWatchlistMovie(
      AddToWatchListMovieEvent event, Emitter<MovieState> emit) async {
    try {
      emit(state.copyWith(movieActionStatus: MovieActionStatus.executing));

      bool result =
          await movieRepository.addWatchlistMovie(event.movie.id ?? 0);

      if (result) {
        List<Movie> movies = [];
        switch (event.category) {
          case MovieCategory.topRated:
            movies = state.listTopRatedMovies ?? [];
            break;
          case MovieCategory.upcoming:
            movies = state.listUpcomingMovies ?? [];
            break;
          case MovieCategory.nowPlaying:
            movies = state.listNowPlayingMovies ?? [];
            break;
          case MovieCategory.popular:
            movies = state.listPopularMovies ?? [];
            break;
        }

        if (!AppGlobalHelper.isEmptyList(movies)) {
          int index = movies.indexOf(event.movie);
          movies[index] = movies[index].copyWith(watchList: true);

          switch (event.category) {
            case MovieCategory.topRated:
              emit(state.copyWith(listTopRatedMovies: movies));
              break;
            case MovieCategory.upcoming:
              emit(state.copyWith(listUpcomingMovies: movies));
              break;
            case MovieCategory.nowPlaying:
              emit(state.copyWith(listNowPlayingMovies: movies));
              break;
            case MovieCategory.popular:
              emit(state.copyWith(listPopularMovies: movies));
              break;
          }
        }
      }

      emit(state.copyWith(movieActionStatus: MovieActionStatus.finished));
      emit(state.copyWith(movieActionStatus: MovieActionStatus.initial));
    } catch (e) {
      if (e is AppException) {
        emit(state.copyWith(
          movieStatus: MovieStatus.error,
          message: e.message,
        ));
      } else {
        emit(state.copyWith(
          movieStatus: MovieStatus.error,
          message: 'Something Wrong',
        ));
      }
    }
  }

  FutureOr<void> _onSearchMovie(
      SearchMovieEvent event, Emitter<MovieState> emit) async {
    try {
      emit(state.copyWith(movieActionStatus: MovieActionStatus.executing));

      List<Movie> result =
          await movieRepository.getSearchMovies(query: event.query);

      emit(state.copyWith(
        movieActionStatus: MovieActionStatus.finished,
        listMovies: result,
        isSearchOn: true,
      ));
      emit(state.copyWith(movieActionStatus: MovieActionStatus.initial));
    } catch (e) {
      if (e is AppException) {
        emit(state.copyWith(
          movieStatus: MovieStatus.error,
          message: e.message,
        ));
      } else {
        emit(state.copyWith(
          movieStatus: MovieStatus.error,
          message: 'Something Wrong',
        ));
      }
    }
  }

  FutureOr<void> _onClearSearchMovie(
      ClearSearchMovieEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(movieActionStatus: MovieActionStatus.executing));

    emit(state.copyWith(
      movieActionStatus: MovieActionStatus.finished,
      listMovies: [],
      isSearchOn: false,
    ));
    emit(state.copyWith(movieActionStatus: MovieActionStatus.initial));
  }
}
