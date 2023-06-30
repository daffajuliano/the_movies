import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:the_movies/core/helpers/global_helper.dart';
import 'package:the_movies/features/movie/bloc/movie_bloc.dart';
import 'package:the_movies/features/movie/widgets/list_item_movie.dart';
import 'package:the_movies/shared/models/movie.dart';
import 'package:the_movies/shared/widgets/empty_view_widget.dart';
import 'package:the_movies/shared/widgets/list_item_shimmer.dart';

class MovieListPage extends StatefulWidget {
  final MovieCategory movieCategory;

  const MovieListPage({
    Key? key,
    required this.movieCategory,
  }) : super(key: key);

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  String getMovieCategoryTitle() {
    switch (widget.movieCategory) {
      case MovieCategory.topRated:
        return 'Top Rated';
      case MovieCategory.upcoming:
        return 'Upcoming';
      case MovieCategory.nowPlaying:
        return 'Now Playing';
      case MovieCategory.popular:
        return 'Popular';
    }
  }

  List<Movie> getMovieByCategory(MovieState state) {
    switch (widget.movieCategory) {
      case MovieCategory.topRated:
        return state.listTopRatedMovies ?? [];
      case MovieCategory.upcoming:
        return state.listUpcomingMovies ?? [];
      case MovieCategory.nowPlaying:
        return state.listNowPlayingMovies ?? [];
      case MovieCategory.popular:
        return state.listPopularMovies ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getMovieCategoryTitle(),
          style: const TextStyle(
            fontFamily: 'Josefin Sans',
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state.movieActionStatus == MovieActionStatus.executing) {
              SmartDialog.showLoading(
                backDismiss: false,
              );
            }

            if (state.movieActionStatus == MovieActionStatus.finished) {
              SmartDialog.dismiss();
            }
          },
          builder: (context, state) {
            if (state.movieStatus != MovieStatus.loading) {
              List<Movie> listMovies = getMovieByCategory(state);
              if (!AppGlobalHelper.isEmptyList(listMovies)) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: listMovies.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) => ListItemMovie(
                    data: listMovies[index],
                    onTapWatchList: () {
                      if (!listMovies[index].watchList) {
                        context.read<MovieBloc>().add(AddToWatchListMovieEvent(
                            movie: listMovies[index],
                            category: widget.movieCategory));
                      }
                    },
                  ),
                );
              } else {
                return const EmptyViewWidget();
              }
            } else {
              return SizedBox(
                width: double.infinity,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 10,
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return const ListItemShimmer();
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
