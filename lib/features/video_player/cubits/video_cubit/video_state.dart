import 'package:equatable/equatable.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';

sealed class VideoState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class VideoInitial extends VideoState {}

final class VideoControllerInitLoading extends VideoState {}

final class VideoControllerInitFail extends VideoState {
  final String errorMessage;

  VideoControllerInitFail(this.errorMessage);
}

final class VideoControllerInitSuccess extends VideoState {}

final class AddedSubtitle extends VideoState {
  final SubtitleController subtitleController;

  AddedSubtitle({required this.subtitleController});

  @override
  List<Object?> get props => [subtitleController.subtitlesContent];
}

final class AddedNewSubtitleFile extends VideoState {}
