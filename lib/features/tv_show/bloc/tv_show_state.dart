part of 'tv_show_bloc.dart';

enum TvShowStatus { initial, loading, loaded, error }
enum TvShowActionStatus { initial, executing, finished, error }

class TvShowState {
  final TvShowStatus tvShowStatus;
  final TvShowActionStatus tvShowActionStatus;
  final List<TvSeries>? listTvShows;
  final List<TvSeries>? listPopularTvShows;
  final List<TvSeries>? listTopRatedTvShows;
  final List<TvSeries>? listOnTheAirTvShows;
  final List<TvSeries>? listAiringTvShows;
  final List<TvSeries>? listWatchlistTvShows;
  final String? message;
  final bool isSearchOn;

  TvShowState({
    this.tvShowStatus = TvShowStatus.initial,
    this.tvShowActionStatus = TvShowActionStatus.initial,
    this.listTvShows,
    this.listPopularTvShows,
    this.listTopRatedTvShows,
    this.listOnTheAirTvShows,
    this.listAiringTvShows,
    this.listWatchlistTvShows,
    this.message,
    this.isSearchOn = false,
  });

  TvShowState copyWith({
    TvShowStatus? tvShowStatus,
    TvShowActionStatus? tvShowActionStatus,
    List<TvSeries>? listTvShows,
    List<TvSeries>? listPopularTvShows,
    List<TvSeries>? listTopRatedTvShows,
    List<TvSeries>? listOnTheAirTvShows,
    List<TvSeries>? listAiringTvShows,
    List<TvSeries>? listWatchlistTvShows,
    String? message,
    bool? isSearchOn,
  }) =>
      TvShowState(
        tvShowStatus: tvShowStatus ?? this.tvShowStatus,
        tvShowActionStatus: tvShowActionStatus ?? this.tvShowActionStatus,
        listTvShows: listTvShows ?? this.listTvShows,
        listPopularTvShows: listPopularTvShows ?? this.listPopularTvShows,
        listTopRatedTvShows: listTopRatedTvShows ?? this.listTopRatedTvShows,
        listOnTheAirTvShows: listOnTheAirTvShows ?? this.listOnTheAirTvShows,
        listAiringTvShows: listAiringTvShows ?? this.listAiringTvShows,
        listWatchlistTvShows: listWatchlistTvShows ?? this.listWatchlistTvShows,
        message: message ?? this.message,
        isSearchOn: isSearchOn ?? this.isSearchOn,
      );
}