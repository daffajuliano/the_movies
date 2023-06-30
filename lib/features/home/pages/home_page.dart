import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_movies/features/home/pages/home_search_page.dart';
import 'package:the_movies/features/movie/bloc/movie_bloc.dart';
import 'package:the_movies/features/movie/widgets/movie_poster_widget.dart';
import 'package:the_movies/features/tv_show/bloc/tv_show_bloc.dart';
import 'package:the_movies/features/tv_show/widgets/tv_show_poster_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[800]),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.film,
              color: Colors.orange.shade600,
            ),
            const SizedBox(width: 6),
            const Text(
              'The Movies',
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeSearchPage(
                    searchType: _tabController.index == 0
                        ? SearchType.movie
                        : SearchType.tvShow,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.orange.shade600,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.orange.shade600,
          tabs: const [
            Tab(text: 'Movies'),
            Tab(text: 'TV Series'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _movies(),
            _tvShows(),
          ],
        ),
      ),
    );
  }

  Widget _movies() {
    return ListView(
      children: const [
        MoviePosterWidget(category: MovieCategory.topRated),
        SizedBox(height: 10),
        MoviePosterWidget(category: MovieCategory.upcoming),
        SizedBox(height: 10),
        MoviePosterWidget(category: MovieCategory.nowPlaying),
        SizedBox(height: 10),
        MoviePosterWidget(category: MovieCategory.popular),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _tvShows() {
    return ListView(
      children: const [
        TvShowPosterWidget(category: TvShowCategory.popular),
        SizedBox(height: 10),
        TvShowPosterWidget(category: TvShowCategory.topRated),
        SizedBox(height: 10),
        TvShowPosterWidget(category: TvShowCategory.onTheAir),
        SizedBox(height: 10),
        TvShowPosterWidget(category: TvShowCategory.airing),
        SizedBox(height: 10),
      ],
    );
  }
}
