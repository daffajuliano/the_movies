import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/core/helpers/global_helper.dart';
import 'package:the_movies/features/tv_show/bloc/tv_show_bloc.dart';
import 'package:the_movies/features/tv_show/pages/tv_show_list_page.dart';
import 'package:the_movies/features/tv_show/widgets/list_poster_tv.dart';
import 'package:the_movies/shared/models/tv_series.dart';
import 'package:the_movies/shared/widgets/empty_view_widget.dart';
import 'package:the_movies/shared/widgets/poster_shimmer.dart';

class TvShowPosterWidget extends StatelessWidget {
  final TvShowCategory category;

  const TvShowPosterWidget({super.key, required this.category});

  String getCategoryTitle() {
    switch (category) {
      case TvShowCategory.popular:
        return 'Popular';
      case TvShowCategory.topRated:
        return 'Top Rated';
      case TvShowCategory.onTheAir:
        return 'On The Air';
      case TvShowCategory.airing:
        return 'Airing';
    }
  }

  List<TvSeries> getTvSeriesByCategory(TvShowState state) {
    switch (category) {
      case TvShowCategory.popular:
        return state.listPopularTvShows ?? [];
      case TvShowCategory.topRated:
        return state.listTopRatedTvShows ?? [];
      case TvShowCategory.onTheAir:
        return state.listOnTheAirTvShows ?? [];
      case TvShowCategory.airing:
        return state.listAiringTvShows ?? [];
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
                getCategoryTitle(),
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
                      builder: (context) => TvShowListPage(
                        category: category,
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
        BlocBuilder<TvShowBloc, TvShowState>(
          builder: (context, state) {
            if (state.tvShowStatus != TvShowStatus.loading) {
              List<TvSeries> tvSeries = getTvSeriesByCategory(state);
              if (!AppGlobalHelper.isEmptyList(tvSeries)) {
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
                        ListPosterTv(data: tvSeries[index]),
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
