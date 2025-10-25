import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/product/domain/entities/banner_entity.dart';
import 'package:snap_shop/features/product/domain/usecases/get_banners_usecase.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final GetBannersUseCase getBannersUseCase;
  BannerCubit({required this.getBannersUseCase}) : super(BannerInitial());

  Future<void> getBanners() async {
    emit(BannerLoading());
    final response = await getBannersUseCase.execute();
    response.fold(
      (f) => emit(BannerFailure(error: f.message)),
      (r) => emit(BannerSuccess(banners: r)),
    );
  }
}
