import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'upload_image_event.dart';
part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  PizzaRepo pizzaRepo;
  UploadImageBloc(this.pizzaRepo) : super(UploadImageLoading()) {
    on<UploadImage>((event, emit) async {
      try {
        String url = await pizzaRepo.sendImage(event.file, event.name);
        emit(UploadImageSuccess(url: url));
      } catch (e) {
        emit(UploadImageFailure());
      }
    });
  }
}
