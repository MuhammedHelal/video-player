class AllVideosState {}

final class VideosInitial extends AllVideosState {}

final class SortByDateSuccess extends AllVideosState {
  final List<String> videosByDate;

  SortByDateSuccess(this.videosByDate);
}

final class SortByDateFail extends AllVideosState {}

final class UpdateDatabaseSuccess extends AllVideosState {}

final class UpdateDatabaseLoading extends AllVideosState {}

final class PermissionGranted extends AllVideosState {}

final class PermissionDenied extends AllVideosState {}

final class PermissionPermenantDenied extends AllVideosState {}
