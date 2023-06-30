import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/features/movie/bloc/movie_bloc.dart';
import 'package:the_movies/features/splash_screen/bloc/splash_screen_cubit.dart';
import 'package:the_movies/features/tv_show/bloc/tv_show_bloc.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade600,
      body: MultiBlocListener(
          listeners: [
            BlocListener<MovieBloc, MovieState>(
              listener: (context, state) {
                if (state.movieStatus == MovieStatus.loaded) {
                  context.read<SplashScreenCubit>().addCompletedCount();
                  context.read<TvShowBloc>().add(LoadAllTvEvent());
                }
              },
            ),
            BlocListener<TvShowBloc, TvShowState>(
              listener: (context, state) {
                if (state.tvShowStatus == TvShowStatus.loaded) {
                  context.read<SplashScreenCubit>().addCompletedCount();
                }
              },
            ),
          ],
          child: BlocBuilder<SplashScreenCubit, SplashScreenState>(
              builder: (context, state) {
            return Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 250,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          state.message,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          })),
    );
  }
}
