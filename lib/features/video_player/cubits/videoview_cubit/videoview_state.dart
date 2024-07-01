part of 'videoview_cubit.dart';

@immutable
sealed class VideoviewState {}

final class VideoviewInitial extends VideoviewState {}

final class ChangeBrightness extends VideoviewState {}

final class CompleteChangeBrightness extends VideoviewState {}

final class Seek extends VideoviewState {}

final class CompletedSeek extends VideoviewState {}

final class ShowControllers extends VideoviewState {}

final class HideControllers extends VideoviewState {}

final class ChangeVolume extends VideoviewState {}

final class CompleteChangeVolume extends VideoviewState {}

final class HorizontalSeek extends VideoviewState {
  final String duration;
  final String totalDuration;

  HorizontalSeek({required this.duration, required this.totalDuration});
}

final class CompleteHorizontalSeek extends VideoviewState {}
