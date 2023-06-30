import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/core/helpers/global_helper.dart';
import 'package:the_movies/features/movie/bloc/movie_bloc.dart';
import 'package:the_movies/features/movie/widgets/list_item_movie.dart';
import 'package:the_movies/features/tv_show/bloc/tv_show_bloc.dart';
import 'package:the_movies/features/tv_show/widgets/list_item_tv.dart';
import 'package:the_movies/shared/widgets/empty_view_widget.dart';

enum SearchType { movie, tvShow }

class HomeSearchPage extends StatefulWidget {
  final SearchType searchType;

  const HomeSearchPage({Key? key, required this.searchType}) : super(key: key);

  @override
  State<HomeSearchPage> createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        switch (widget.searchType) {
          case SearchType.movie:
            context.read<MovieBloc>().add(ClearSearchMovieEvent());
            break;
          case SearchType.tvShow:
            context.read<TvShowBloc>().add(ClearSearchTvShowEvent());
            break;
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search ${widget.searchType.name}...',
              suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                  switch (widget.searchType) {
                    case SearchType.movie:
                      context.read<MovieBloc>().add(ClearSearchMovieEvent());
                      break;
                    case SearchType.tvShow:
                      context.read<TvShowBloc>().add(ClearSearchTvShowEvent());
                      break;
                  }
                },
                icon: const Icon(Icons.close),
              ),
              border: InputBorder.none,
            ),
            onSubmitted: (String val) {
              switch (widget.searchType) {
                case SearchType.movie:
                  context.read<MovieBloc>().add(SearchMovieEvent(query: val));
                  break;
                case SearchType.tvShow:
                  context.read<TvShowBloc>().add(SearchTvShowEvent(query: val));
                  break;
              }
            },
          ),
        ),
        body: _getListView(),
      ),
    );
  }

  Widget _getListView() {
    switch (widget.searchType) {
      case SearchType.movie:
        return _movieList();
      case SearchType.tvShow:
        return _tvShowList();
    }
  }

  Widget _movieList() {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.movieActionStatus != MovieActionStatus.executing) {
          if (!AppGlobalHelper.isEmptyList(state.listMovies)) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) =>
              const SizedBox(height: 12),
              itemCount: state.listMovies!.length,
              itemBuilder: (context, index) {
                var result = state.listMovies![index];
                return ListItemMovie(
                  data: result,
                  onTapWatchList: () {},
                );
              },
            );
          } else {
            if (state.isSearchOn) {
              return const EmptyViewWidget();
            } else {
              return const SizedBox();
            }
          }
        } else {
          return Center(
            child: CircularProgressIndicator(color: Colors.orange.shade600),
          );
        }
      },
    );
  }

  Widget _tvShowList() {
    return BlocBuilder<TvShowBloc, TvShowState>(
      builder: (context, state) {
        if (state.tvShowActionStatus != TvShowActionStatus.executing) {
          if (!AppGlobalHelper.isEmptyList(state.listTvShows)) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) =>
              const SizedBox(height: 12),
              itemCount: state.listTvShows!.length,
              itemBuilder: (context, index) {
                var result = state.listTvShows![index];
                return ListItemTv(
                  data: result,
                  onTapWatchList: () {},
                );
              },
            );
          } else {
            if (state.isSearchOn) {
              return const EmptyViewWidget();
            } else {
              return const SizedBox();
            }
          }
        } else {
          return Center(
            child: CircularProgressIndicator(color: Colors.orange.shade600),
          );
        }
      },
    );
  }
}
