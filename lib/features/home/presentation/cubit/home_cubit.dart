import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/features/home/presentation/cubit/home_state.dart';

// Cubit class
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  void changeIndex(int newIndex) {
    if (state.currentIndex == newIndex) return;
    emit(HomeIndexChanged(newIndex));
  }
}
