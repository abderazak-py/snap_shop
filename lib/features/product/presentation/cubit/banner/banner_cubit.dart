import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../domain/entities/banner_entity.dart';
import '../../../domain/usecases/get_banners_usecase.dart';

part 'banner_state.dart';

class BannerCubit extends HydratedCubit<BannerState> {
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

  @override
  BannerState? fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    if (type == 'success') {
      final list = (json['banners'] as List<dynamic>? ?? [])
          .map((e) => BannerEntity.fromJson(e as Map<String, dynamic>))
          .toList();
      return BannerSuccess(banners: list);
    }
    if (type == 'failure') {
      return BannerFailure(error: json['error'] as String? ?? '');
    }
    return BannerInitial();
  }

  @override
  Map<String, dynamic>? toJson(BannerState state) {
    if (state is BannerSuccess) {
      return {
        'type': 'success',
        'banners': state.banners.map((b) => b.toJson()).toList(),
      };
    }
    if (state is BannerFailure) {
      return {'type': 'failure', 'error': state.error};
    }
    return null;
  }
}
