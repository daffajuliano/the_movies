part of 'splash_screen_cubit.dart';

class SplashScreenState {
  final int completedCount;
  final bool isLoadCompleted;
  final String message;

  SplashScreenState({
    this.completedCount = 0,
    this.isLoadCompleted = false,
    this.message = 'Loading movie data...',
  });

  SplashScreenState copyWith(
          {int? completedCount, bool? isLoadCompleted, String? message}) =>
      SplashScreenState(
        completedCount: completedCount ?? this.completedCount,
        isLoadCompleted: isLoadCompleted ?? this.isLoadCompleted,
        message: message ?? this.message,
      );
}
