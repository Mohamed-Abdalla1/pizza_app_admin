part of 'upload_image_bloc.dart';

sealed class UploadImageState extends Equatable {
  const UploadImageState();
  
  @override
  List<Object> get props => [];
}

final class UploadImageInitial extends UploadImageState {}