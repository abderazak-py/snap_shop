import 'package:equatable/equatable.dart';

// State classes
abstract class HomeState extends Equatable {
  final int currentIndex;
  const HomeState({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}

class HomeInitial extends HomeState {
  const HomeInitial() : super(currentIndex: 0);
}

class HomeIndexChanged extends HomeState {
  const HomeIndexChanged(int index) : super(currentIndex: index);
}
