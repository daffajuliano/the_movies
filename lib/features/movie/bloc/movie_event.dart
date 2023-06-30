part of 'movie_bloc.dart';

enum MovieCategory {
  topRated,
  upcoming,
  nowPlaying,
  popular,
}
class MovieEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadAllMovieEvent extends MovieEvent {}

class LoadCategoryMovieEvent extends MovieEvent {
  final MovieCategory category;

  LoadCategoryMovieEvent(this.category);
}

class AddToWatchListMovieEvent extends MovieEvent {
  final Movie movie;
  final MovieCategory category;

  AddToWatchListMovieEvent({required this.movie, required this.category});
}

class SearchMovieEvent extends MovieEvent {
  final String query;

  SearchMovieEvent({required this.query});
}

class ClearSearchMovieEvent extends MovieEvent {
  ClearSearchMovieEvent();
}