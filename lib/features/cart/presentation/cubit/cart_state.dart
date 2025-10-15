part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  const CartSuccess(this.cart);
  final List<CartEntity> cart;
}

final class CartFailure extends CartState {
  const CartFailure(this.error);
  final String error;
}
