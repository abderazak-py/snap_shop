import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/features/cart/domain/entities/cart_entity.dart';
import 'package:snap_shop/features/cart/domain/usecases/get_cart_items_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void getCartItems() async {
    emit(CartLoading());
    debugPrint('Starting getCartItems');
    final cartItems = await sl<GetCartItemsUsecase>().execute();
    debugPrint('Starting getCartItems DONE ++++++++++++');
    cartItems.fold(
      (failure) => emit(CartFailure(failure.message)),
      (cart) => emit(CartSuccess(cart)),
    );
  }
}
