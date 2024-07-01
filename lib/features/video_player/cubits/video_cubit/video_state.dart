sealed class VideoState {}

final class VideoInitial extends VideoState {}

final class VideoControllerInitLoading extends VideoState {}

final class VideoControllerInitFail extends VideoState {
  final String errorMessage;

  VideoControllerInitFail(this.errorMessage);
}

final class VideoControllerInitSuccess extends VideoState {}
