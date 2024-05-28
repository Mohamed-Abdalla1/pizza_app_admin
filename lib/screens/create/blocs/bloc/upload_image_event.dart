part of 'upload_image_bloc.dart';

sealed class UploadImageEvent extends Equatable {
  const UploadImageEvent();

  @override
  List<Object> get props => [];
}

class UploadImage extends UploadImageEvent {
  final Uint8List file;
  final String name;

 const UploadImage({required this.file, required this.name});

  @override
  List<Object> get props => [file,name];
}
