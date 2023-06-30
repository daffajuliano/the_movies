part of 'movie_bloc.dart';

enum MovieStatus { initial, loading, loaded, error }
enum MovieActionStatus { initial, executing, finished, error }

class MovieState {
  final MovieStatus movieStatus;
  final MovieActionStatus movieActionStatus;
  final List<Movie>? listMovies;
  final List<Movie>? listTopRatedMovies;
  final List<Movie>? listUpcomingMovies;
  final List<Movie>? listNowPlayingMovies;
  final List<Movie>? listPopularMovies;
  final List<Movie>? listWatchlistMovies;
  final String? message;
  final bool isSearchOn;

  MovieState({
    this.movieStatus = MovieStatus.initial,
    this.movieActionStatus = MovieActionStatus.initial,
    this.listMovies,
    this.listTopRatedMovies,
    this.listUpcomingMovies,
    this.listNowPlayingMovies,
    this.listPopularMovies,
    this.listWatchlistMovies,
    this.message,
    this.isSearchOn = false,
  });

  MovieState copyWith({
    MovieStatus? movieStatus,
    MovieActionStatus? movieActionStatus,
    List<Movie>? listMovies,
    List<Movie>? listTopRatedMovies,
    List<Movie>? listUpcomingMovies,
    List<Movie>? listNowPlayingMovies,
    List<Movie>? listPopularMovies,
    List<Movie>? listWatchlistMovies,
    String? message,
    bool? isSearchOn,
  }) =>
      MovieState(
        movieStatus: movieStatus ?? this.movieStatus,
        movieActionStatus: movieActionStatus ?? this.movieActionStatus,
        listMovies: listMovies ?? this.listMovies,
        listTopRatedMovies: listTopRatedMovies ?? this.listTopRatedMovies,
        listUpcomingMovies: listUpcomingMovies ?? this.listUpcomingMovies,
        listNowPlayingMovies: listNowPlayingMovies ?? this.listNowPlayingMovies,
        listPopularMovies: listPopularMovies ?? this.listPopularMovies,
        listWatchlistMovies: listWatchlistMovies ?? this.listWatchlistMovies,
        message: message ?? this.message,
        isSearchOn: isSearchOn ?? this.isSearchOn,
      );
}
