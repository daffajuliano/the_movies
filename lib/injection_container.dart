import 'package:get_it/get_it.dart';
import 'package:the_movies/core/config/dio_config.dart';
import 'package:the_movies/features/movie/bloc/movie_bloc.dart';
import 'package:the_movies/features/splash_screen/bloc/splash_screen_cubit.dart';
import 'package:the_movies/features/tv_show/bloc/tv_show_bloc.dart';
import 'package:the_movies/shared/repositories/movie_repository.dart';
import 'package:the_movies/shared/repositories/tv_show_repository.dart';

var sl = GetIt.instance;

Future<void> initLocator() async {
  /// Core
  sl.registerSingleton(AppDio().dio);

  /// Repository
  sl.registerLazySingleton(() => MovieRepository(sl()));
  sl.registerLazySingleton(() => TvShowRepository(sl()));

  /// Bloc
  sl.registerFactory(() => SplashScreenCubit());
  sl.registerFactory(() => MovieBloc(movieRepository: sl()));
  sl.registerFactory(() => TvShowBloc(tvShowRepository: sl()));
}