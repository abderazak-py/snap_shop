// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:snap_shop/features/cart/domain/entities/cart_entity.dart';
import 'package:snap_shop/features/cart/domain/usecases/add_one_to_cart_usecase.dart';
import 'package:snap_shop/features/cart/domain/usecases/get_cart_items_usecase.dart';
import 'package:snap_shop/features/cart/domain/usecases/remove_one_from_cart_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItemsUsecase getCartItemsUsecase;
  final AddOneToCartUsecase addOneToCartUsecase;
  final RemoveOneFromCartUsecase removeOneFromCartUsecase;
  CartCubit({
    required this.getCartItemsUsecase,
    required this.addOneToCartUsecase,
    required this.removeOneFromCartUsecase,
  }) : super(CartInitial());

  void getCartItems() async {
    emit(CartLoading());
    debugPrint('Starting getCartItems');
    final response = await getCartItemsUsecase.execute();
    debugPrint('Starting getCartItems DONE ++++++++++++');
    response.fold(
      (failure) => emit(CartFailure(failure.message)),
      (cart) => emit(CartSuccess(cart)),
    );
  }

  void updateQuantity(int productId, bool add) async {
    if (state is! CartSuccess) return;
    final currentState = state as CartSuccess;
    final currentCart = currentState.cart;

    // Update UI immediately before making the API call
    final updatedCart = currentCart
        .map((item) {
          if (item.productId == productId) {
            final newQty = add ? item.quantity + 1 : item.quantity - 1;
            return item.copyWith(quantity: newQty);
          }
          return item;
        })
        .where((item) => item.quantity > 0)
        .toList();

    emit(CartSuccess(updatedCart));

    // Callapi after updating ui
    final response = add
        ? await addOneToCartUsecase.execute(productId)
        : await removeOneFromCartUsecase.execute(productId);

    response.fold((failure) {
      // if failed, revert the change maybe
      debugPrint('Failed to sync with server: $failure');
    }, (_) => debugPrint('Server synced'));
  }

  //for check box
  void toggleSelection(int productId) {
    if (state is! CartSuccess) return;
    final currentState = state as CartSuccess;

    final updatedCart = currentState.cart.map((item) {
      if (item.productId == productId) {
        return item.copyWith(isSelected: !item.isSelected);
      }
      return item;
    }).toList();

    emit(CartSuccess(updatedCart));
  }
}
