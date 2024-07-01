import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/core/functions/format_duration.dart';
import 'package:volume_controller/volume_controller.dart';

part 'videoview_state.dart';

class VideoviewCubit extends Cubit<VideoviewState> {
  VideoviewCubit() : super(VideoviewInitial()) {
    initVolume();
    initBrightness();
  }

  double initialY = 0;
  late double brightness;
  late ScreenBrightness _screenBrightness;
  late VolumeController volumeController;
  late double volume;
  final int timerSeconds = 3;

  Future<void> initVolume() async {
    volumeController = VolumeController();
    volumeController.showSystemUI = false;
    volume = await volumeController.getVolume();
  }

  Future<void> initBrightness() async {
    _screenBrightness = ScreenBrightness();

    brightness = await _screenBrightness.current;
  }
  
  final TransformationController transformationController =
      TransformationController();

  void showOrHideController() {
    if (state is ShowControllers) {
      emit(HideControllers());
    } else {
      showControllers();
    }
  }

  void showSeekOverlay() {
    emit(Seek());
    if (timer == null) {
      timer = Timer(
        Duration(seconds: timerSeconds),
        () => emit(CompletedSeek()),
      );
    } else {
      timer!.cancel();
      timer = Timer(
        Duration(seconds: timerSeconds),
        () => emit(CompletedSeek()),
      );
    }
  }

  void showVolumeOverlay() {
    emit(ChangeVolume());
    if (timer == null) {
      timer = Timer(
        Duration(seconds: timerSeconds),
        () => emit(CompleteChangeVolume()),
      );
    } else {
      timer!.cancel();
      timer = Timer(
        Duration(seconds: timerSeconds),
        () => emit(CompleteChangeVolume()),
      );
    }
  }

  Timer? timer;
  void showControllers() {
    emit(ShowControllers());
    if (timer == null) {
      timer = Timer(
        Duration(seconds: timerSeconds),
        () => emit(HideControllers()),
      );
    } else {
      timer!.cancel();
      timer = Timer(
        Duration(seconds: timerSeconds),
        () => emit(HideControllers()),
      );
    }
  }

  void showhoriontalSeek(
      {required String duration, required String totalDuration}) {
    emit(HorizontalSeek(duration: duration, totalDuration: totalDuration));
    if (timer == null) {
      timer = Timer(
        Duration(seconds: timerSeconds),
        () => emit(CompleteHorizontalSeek()),
      );
    } else {
      timer!.cancel();
      timer = Timer(
        Duration(seconds: timerSeconds),
        () => emit(CompleteHorizontalSeek()),
      );
    }
  }

  Future<void> onLeftVerticalDragUpdate(DragUpdateDetails details) async {
    double deltaY = initialY - details.localPosition.dy;

    // Adjust brightness based on deltaY
    if (deltaY > 10) {
      await increaseBrightness();
      initialY = details.localPosition.dy;
    } else if (deltaY < -10) {
      await decreaseBrightness();
      initialY = details.localPosition.dy;
    }
  }

  Future<void> onHorizontalSeekUpdate({
    required details,
    required VideoPlayerController videoPlayerController,
    required double width,
  }) async {
    duration ??= videoPlayerController.value.position;
    final Duration totalDuration = videoPlayerController.value.duration;
    showhoriontalSeek(
      duration: formatDuration(duration!),
      totalDuration: formatDuration(totalDuration),
    );

    double fraction = details.primaryDelta! / width;
    position =
        (duration!.inMilliseconds + (totalDuration.inMilliseconds * fraction))
            .round();
    position = position.clamp(0, totalDuration.inMilliseconds);
    duration = Duration(milliseconds: position);
  }

  Duration? duration;

  int position = 0;
  Future<void> onHorizontalSeekEnd({
    required VideoPlayerController videoPlayerController,
  }) async {
    await videoPlayerController.seekTo(
      Duration(milliseconds: position),
    );
  }

  Future<void> increaseBrightness() async {
    brightness += 0.05;
    if (brightness > 1.0) brightness = 1.0;
    await ScreenBrightness().setScreenBrightness(brightness);
    showBrigtnessChangeOverlay();
  }

  Future<void> decreaseBrightness() async {
    brightness -= 0.05;
    if (brightness < 0.0) brightness = 0.0;
    await ScreenBrightness().setScreenBrightness(brightness);
    showBrigtnessChangeOverlay();
  }

  Future<void> onRightVerticalDragUpdate(DragUpdateDetails details) async {
    double deltaY = initialY - details.localPosition.dy;

    if (deltaY > 10) {
      await increaseVolume();
      initialY = details.localPosition.dy;
    } else if (deltaY < -10) {
      await decreaseVolume();
      initialY = details.localPosition.dy;
    }
  }

  Future<void> increaseVolume() async {
    volume += 0.05;
    if (volume > 1.0) volume = 1.0;
    volumeController.setVolume(volume);
    showVolumeOverlay();
  }

  Future<void> decreaseVolume() async {
    volume -= 0.05;
    if (volume < 0.0) volume = 0.0;
    volumeController.setVolume(volume);
    showVolumeOverlay();
  }

  void showBrigtnessChangeOverlay() {
    emit(ChangeBrightness());
    if (timer == null) {
      timer = Timer(
        Duration(seconds: timerSeconds),
        () => emit(CompleteChangeBrightness()),
      );
    } else {
      timer!.cancel();
      timer = Timer(
        Duration(seconds: timerSeconds),
        () => emit(CompleteChangeBrightness()),
      );
    }
  }
}
