// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:burger_delivery/src/services/services.dart';

part 'cart_count_state.dart';

class CartCountCubit extends Cubit<CartCountState> {
  CartCountCubit() : super(CartCountIsSuccess(0));

  void getCartCount() async {
    final result = await ProductService().getCartItemCount();
    emit(
        result.fold((l) => CartCountIsFailed(l), (r) => CartCountIsSuccess(r)));
  }
}
