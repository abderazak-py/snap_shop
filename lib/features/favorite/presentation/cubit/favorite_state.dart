part of 'favorite_cubit.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteSuccess extends FavoriteState {
  const FavoriteSuccess(this.favorite);
  final List<FavoriteEntity> favorite;

  @override
  List<Object> get props => [favorite];
}

final class FavoriteFailure extends FavoriteState {
  const FavoriteFailure(this.error);
  final String error;
}
