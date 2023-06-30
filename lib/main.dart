import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:the_movies/features/home/pages/home_page.dart';
import 'package:the_movies/features/movie/bloc/movie_bloc.dart';
import 'package:the_movies/features/splash_screen/bloc/splash_screen_cubit.dart';
import 'package:the_movies/features/splash_screen/pages/splash_screen_page.dart';
import 'package:the_movies/features/tv_show/bloc/tv_show_bloc.dart';
import 'package:the_movies/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashScreenCubit>(create: (_) => sl<SplashScreenCubit>()),
        BlocProvider<MovieBloc>(
            create: (_) => sl<MovieBloc>()..add(LoadAllMovieEvent())),
        BlocProvider<TvShowBloc>(create: (_) => sl<TvShowBloc>()),
      ],
      child: MaterialApp(
        title: 'The Movies',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade600),
          useMaterial3: true,
        ),
        home: BlocBuilder<SplashScreenCubit, SplashScreenState>(
          builder: (context, state) {
            if (state.isLoadCompleted) {
              return const HomePage();
            } else {
              return const SplashScreenPage();
            }
          },
        ),
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}
