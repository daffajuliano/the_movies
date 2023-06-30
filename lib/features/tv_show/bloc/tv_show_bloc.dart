import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/core/errors/exceptions.dart';
import 'package:the_movies/core/helpers/global_helper.dart';
import 'package:the_movies/shared/models/tv_series.dart';
import 'package:the_movies/shared/repositories/tv_show_repository.dart';

part 'tv_show_event.dart';
part 'tv_show_state.dart';

class TvShowBloc extends Bloc<TvShowEvent, TvShowState> {
  final TvShowRepository tvShowRepository;

  TvShowBloc({required this.tvShowRepository}) : super(TvShowState()) {
    on<LoadAllTvEvent>(_onLoadAllTv);
    on<AddToWatchListTvEvent>(_onAddToWatchlistTv);
    on<SearchTvShowEvent>(_onSearchTvShow);
    on<ClearSearchTvShowEvent>(_onClearSearchTvShow);
  }

  FutureOr<void> _onLoadAllTv(
      LoadAllTvEvent event, Emitter<TvShowState> emit) async {
    try {
      emit(state.copyWith(tvShowStatus: TvShowStatus.loading));

      List<TvSeries> popular = await tvShowRepository.getPopularTvShow();
      List<TvSeries> topRated = await tvShowRepository.getTopRatedTvShow();
      List<TvSeries> onTheAir = await tvShowRepository.getOnTheAirTvShow();
      List<TvSeries> airing = await tvShowRepository.getAiringTvShow();
      List<TvSeries> watchlist = await tvShowRepository.getWatchlistTvShow();

      // check if movies has watchlist
      if (!AppGlobalHelper.isEmptyList(watchlist)) {
        for (var w in watchlist) {
          int popularIndex =
          popular.indexWhere((element) => w.id == element.id);
          if (popularIndex >= 0) {
            popular[popularIndex] =
                popular[popularIndex].copyWith(watchList: true);
          }
          
          int topRatedIndex =
          topRated.indexWhere((element) => w.id == element.id);
          if (topRatedIndex >= 0) {
            topRated[topRatedIndex] =
                topRated[topRatedIndex].copyWith(watchList: true);
          }
          
          int onTheAirIndex =
          onTheAir.indexWhere((element) => w.id == element.id);
          if (onTheAirIndex >= 0) {
            onTheAir[onTheAirIndex] =
                onTheAir[onTheAirIndex].copyWith(watchList: true);
          }

          int airingIndex =
          airing.indexWhere((element) => w.id == element.id);
          if (airingIndex >= 0) {
            airing[airingIndex] =
                airing[airingIndex].copyWith(watchList: true);
          }
        }
      }

      emit(state.copyWith(
        tvShowStatus: TvShowStatus.loaded,
        listPopularTvShows: popular,
        listTopRatedTvShows: topRated,
        listOnTheAirTvShows: onTheAir,
        listAiringTvShows: airing,
        listWatchlistTvShows: watchlist,
      ));

      emit(state.copyWith(tvShowStatus: TvShowStatus.initial));
    } catch (e) {
      if (e is AppException) {
        emit(state.copyWith(
          tvShowStatus: TvShowStatus.error,
          message: e.message,
        ));
        emit(state.copyWith(tvShowStatus: TvShowStatus.initial));
      } else {
        emit(state.copyWith(
          tvShowStatus: TvShowStatus.error,
          message: 'Something Wrong',
        ));
        emit(state.copyWith(tvShowStatus: TvShowStatus.initial));
      }
    }
  }

  FutureOr<void> _onAddToWatchlistTv(
      AddToWatchListTvEvent event, Emitter<TvShowState> emit) async {
    try {
      emit(state.copyWith(tvShowActionStatus: TvShowActionStatus.executing));

      bool result =
      await tvShowRepository.addWatchlistTvShow(event.tvSeries.id ?? 0);

      if (result) {
        List<TvSeries> movies = [];
        switch (event.category) {
          case TvShowCategory.popular:
            movies = state.listPopularTvShows ?? [];
            break;
          case TvShowCategory.topRated:
            movies = state.listTopRatedTvShows ?? [];
            break;
          case TvShowCategory.onTheAir:
            movies = state.listOnTheAirTvShows ?? [];
            break;
          case TvShowCategory.airing:
            movies = state.listAiringTvShows ?? [];
            break;
        }

        if (!AppGlobalHelper.isEmptyList(movies)) {
          int index = movies.indexOf(event.tvSeries);
          movies[index] = movies[index].copyWith(watchList: true);

          switch (event.category) {
            case TvShowCategory.popular:
              emit(state.copyWith(listPopularTvShows: movies));
              break;
            case TvShowCategory.topRated:
              emit(state.copyWith(listTopRatedTvShows: movies));
              break;
            case TvShowCategory.onTheAir:
              emit(state.copyWith(listOnTheAirTvShows: movies));
              break;
            case TvShowCategory.airing:
              emit(state.copyWith(listAiringTvShows: movies));
              break;
          }
        }
      }

      emit(state.copyWith(tvShowActionStatus: TvShowActionStatus.finished));
      emit(state.copyWith(tvShowActionStatus: TvShowActionStatus.initial));
    } catch (e) {
      if (e is AppException) {
        emit(state.copyWith(
          tvShowActionStatus: TvShowActionStatus.error,
          message: e.message,
        ));
        emit(state.copyWith(tvShowActionStatus: TvShowActionStatus.initial));
      } else {
        emit(state.copyWith(
          tvShowActionStatus: TvShowActionStatus.error,
          message: 'Something Wrong',
        ));
        emit(state.copyWith(tvShowActionStatus: TvShowActionStatus.initial));
      }
    }
  }

  FutureOr<void> _onSearchTvShow(
      SearchTvShowEvent event, Emitter<TvShowState> emit) async {
    try {
      emit(state.copyWith(tvShowActionStatus: TvShowActionStatus.executing));

      List<TvSeries> result =
      await tvShowRepository.getSearchTvShows(query: event.query);

      emit(state.copyWith(
        tvShowActionStatus: TvShowActionStatus.finished,
        listTvShows: result,
        isSearchOn: true,
      ));
      emit(state.copyWith(tvShowActionStatus: TvShowActionStatus.initial));
    } catch (e) {
      if (e is AppException) {
        emit(state.copyWith(
          tvShowStatus: TvShowStatus.error,
          message: e.message,
        ));
      } else {
        emit(state.copyWith(
          tvShowStatus: TvShowStatus.error,
          message: 'Something Wrong',
        ));
      }
    }
  }

  FutureOr<void> _onClearSearchTvShow(
      ClearSearchTvShowEvent event, Emitter<TvShowState> emit) async {
    emit(state.copyWith(tvShowActionStatus: TvShowActionStatus.executing));

    emit(state.copyWith(
      tvShowActionStatus: TvShowActionStatus.finished,
      listTvShows: [],
      isSearchOn: false,
    ));
    emit(state.copyWith(tvShowActionStatus: TvShowActionStatus.initial));
  }
}
