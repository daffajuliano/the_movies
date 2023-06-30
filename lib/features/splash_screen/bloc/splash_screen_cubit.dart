import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenState());


  void addCompletedCount() {
    int completed = state.completedCount + 1;
    bool isCompleted = false;
    String message = state.message;

    if (completed == 1) {
      message = 'Loading tv show data...';
    }
    if (completed >= 2) {
      isCompleted = true;
    }

    emit(state.copyWith(
      completedCount: completed,
      isLoadCompleted: isCompleted,
      message: message,
    ));
  }
}
