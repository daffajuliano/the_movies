part of 'tv_show_bloc.dart';

enum TvShowCategory {
  popular,
  topRated,
  onTheAir,
  airing,
}
class TvShowEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAllTvEvent extends TvShowEvent {}

class LoadCategoryTvEvent extends TvShowEvent {
  final TvShowCategory category;

  LoadCategoryTvEvent(this.category);
}

class AddToWatchListTvEvent extends TvShowEvent {
  final TvSeries tvSeries;
  final TvShowCategory category;

  AddToWatchListTvEvent({required this.tvSeries, required this.category});
}

class SearchTvShowEvent extends TvShowEvent {
  final String query;

  SearchTvShowEvent({required this.query});
}

class ClearSearchTvShowEvent extends TvShowEvent {
  ClearSearchTvShowEvent();
}
