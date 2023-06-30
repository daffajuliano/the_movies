import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/core/helpers/global_helper.dart';
import 'package:the_movies/features/movie/bloc/movie_bloc.dart';
import 'package:the_movies/features/movie/pages/movie_list_page.dart';
import 'package:the_movies/features/movie/widgets/list_poster_movie.dart';
import 'package:the_movies/shared/models/movie.dart';
import 'package:the_movies/shared/widgets/empty_view_widget.dart';
import 'package:the_movies/shared/widgets/poster_shimmer.dart';

class MoviePosterWidget extends StatelessWidget {
  final MovieCategory category;

  const MoviePosterWidget({super.key, required this.category});

  String getMovieCategoryTitle() {
    switch (category) {
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
    switch (category) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getMovieCategoryTitle(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieListPage(
                        movieCategory: category,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'View more',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state.movieStatus != MovieStatus.loading) {
              List<Movie> movies = getMovieByCategory(state);
              if (!AppGlobalHelper.isEmptyList(movies)) {
                return Container(
                  constraints: const BoxConstraints(
                    maxHeight: 280,
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 5,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) =>
                    const SizedBox(width: 12),
                    itemBuilder: (context, index) =>
                        ListPosterMovie(data: movies[index]),
                  ),
                );
              } else {
                return const EmptyViewWidget();
              }
            } else {
              return SizedBox(
                height: 280,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) =>
                  const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return const PosterShimmer();
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
