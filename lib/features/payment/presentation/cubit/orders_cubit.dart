import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/payment/domain/entities/order_entity.dart';
import 'package:snap_shop/features/payment/domain/usecases/get_orders_usecase.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUsecase getOrdersUsecase;
  OrdersCubit({required this.getOrdersUsecase}) : super(OrdersInitial());

  getOrders() async {
    emit(OrdersLoading());
    final result = await getOrdersUsecase.execute();
    result.fold(
      (l) => emit(OrdersFailure(l.message)),
      (r) => emit(OrdersSuccess(r)),
    );
  }
}
