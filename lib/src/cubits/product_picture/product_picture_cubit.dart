// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:burger_delivery/src/utilities/utilities.dart';
import 'package:meta/meta.dart';

part 'product_picture_state.dart';

class ProductPictureCubit extends Cubit<ProductPictureState> {
  ProductPictureCubit() : super(ProductPictureInitial());

  void getImage() async {
    final listData = (state is ProductPictureIsLoaded)
        ? (state as ProductPictureIsLoaded).files
        : <File>[];

    final file = await Commons().getImage();
    if (file.path.isNotEmpty) {
      listData.add(file);
      emit(ProductPictureIsLoaded(files: listData));
    } else {
      emit(ProductPictureIsFailed());
    }
  }

  void resetImage() {
    emit(ProductPictureInitial());
  }

  void deleteImage(int id) {
    final listData = (state as ProductPictureIsLoaded).files;
    listData.removeAt(id);
    emit(ProductPictureIsLoaded(files: listData));
  }
}
