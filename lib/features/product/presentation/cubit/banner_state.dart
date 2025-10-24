part of 'banner_cubit.dart';

sealed class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

final class BannerInitial extends BannerState {}

final class BannerLoading extends BannerState {}

final class BannerSuccess extends BannerState {
  final List<BannerEntity> banners;
  const BannerSuccess({required this.banners});
}

final class BannerFailure extends BannerState {
  final String error;
  const BannerFailure({required this.error});
}
