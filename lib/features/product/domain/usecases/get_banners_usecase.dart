import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/banner_entity.dart';
import '../repos/product_repo.dart';

class GetBannersUseCase {
  final ProductRepository repository;

  GetBannersUseCase(this.repository);

  Future<Either<Failure, List<BannerEntity>>> execute() async {
    return await repository.getBanners();
  }
}
