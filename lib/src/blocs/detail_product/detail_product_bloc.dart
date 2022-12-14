// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:burger_delivery/src/models/models.dart';
import 'package:burger_delivery/src/services/services.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  DetailProductBloc() : super(DetailProductInitial()) {
    on<FetchDetailProduct>((event, emit) async {
      emit(DetailProductIsLoading());
      final result = await ProductService().fetchDetailProduct(event.docId);

      emit(result.fold((l) => DetailProductIsFailed(message: l),
          (r) => DetailProductIsSuccess(data: r)));
    });
  }
}
