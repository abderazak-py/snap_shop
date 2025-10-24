import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/product/domain/entities/banner_entity.dart';
import 'package:snap_shop/features/product/domain/repos/product_repo.dart';

class GetBannersUseCase {
  final ProductRepository repository;

  GetBannersUseCase(this.repository);

  Future<Either<Failure, List<BannerEntity>>> execute() async {
    return await repository.getBanners();
  }
}
