// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:burger_delivery/src/services/services.dart';
import 'package:meta/meta.dart';

part 'check_saved_state.dart';

class CheckSavedCubit extends Cubit<CheckSavedState> {
  CheckSavedCubit() : super(CheckSavedInitial());

  void checkWishList(String id) async {
    final result = await ProductService().checkWishList(id);
    emit(result.fold((l) => CheckSavedIsFailed(),
        (r) => (r) ? CheckSavedIsSuccess() : CheckSavedIsFailed()));
  }
}
