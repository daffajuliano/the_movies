import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:the_movies/core/helpers/global_helper.dart';
import 'package:the_movies/features/tv_show/bloc/tv_show_bloc.dart';
import 'package:the_movies/features/tv_show/widgets/list_item_tv.dart';
import 'package:the_movies/shared/models/tv_series.dart';
import 'package:the_movies/shared/widgets/empty_view_widget.dart';
import 'package:the_movies/shared/widgets/list_item_shimmer.dart';

class TvShowListPage extends StatelessWidget {
  final TvShowCategory category;

  const TvShowListPage({
    Key? key,
    required this.category,
  }) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getCategoryTitle(),
          style: const TextStyle(
            fontFamily: 'Josefin Sans',
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<TvShowBloc, TvShowState>(
          listener: (context, state) {
            if (state.tvShowActionStatus == TvShowActionStatus.executing) {
              SmartDialog.showLoading(
                backDismiss: false,
              );
            }

            if (state.tvShowActionStatus == TvShowActionStatus.finished) {
              SmartDialog.dismiss();
            }
          },
          builder: (context, state) {
            if (state.tvShowStatus != TvShowStatus.loading) {
              List<TvSeries> listTvShow = getTvSeriesByCategory(state);
              if (!AppGlobalHelper.isEmptyList(listTvShow)) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: listTvShow.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 12),
                  itemBuilder: (context, index) => ListItemTv(
                    data: listTvShow[index],
                    onTapWatchList: () {
                      if (!listTvShow[index].watchList) {
                        context.read<TvShowBloc>().add(AddToWatchListTvEvent(
                            tvSeries: listTvShow[index],
                            category: category));
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
