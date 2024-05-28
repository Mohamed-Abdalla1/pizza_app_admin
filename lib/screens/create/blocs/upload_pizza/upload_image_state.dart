part of 'upload_image_bloc.dart';

sealed class UploadImageState extends Equatable {
  const UploadImageState();

  @override
  List<Object> get props => [];
}

final class UploadImageInitial extends UploadImageState {}

final class UploadImageLoading extends UploadImageState {}

final class UploadImageSuccess extends UploadImageState {
  final String url;

  const UploadImageSuccess({required this.url});
}

final class UploadImageFailure extends UploadImageState {}
