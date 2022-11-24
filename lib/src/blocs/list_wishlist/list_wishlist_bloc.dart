// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:burger_delivery/src/models/models.dart';
import 'package:burger_delivery/src/services/services.dart';
import 'package:meta/meta.dart';

part 'list_wishlist_event.dart';
part 'list_wishlist_state.dart';

class ListWishlistBloc extends Bloc<ListWishlistEvent, ListWishlistState> {
  ListWishlistBloc() : super(ListWishlistInitial()) {
    on<FetchListWishlist>((event, emit) async {
      emit(ListWishlistIsLoading());
      final result = await ProductService().fetchListWishlist();

      emit(result.fold(
          (l) => ListWishlistIsFailed(l), (r) => ListWishlistIsSuccess(r)));
    });
  }
}
