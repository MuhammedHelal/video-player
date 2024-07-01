import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/features/video_player/cubits/video_cubit/video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitial());
  bool isFloating = false;
  bool looping = false;
  ValueNotifier speedNotifier = ValueNotifier<double>(10);
  int forwardSeconds = 5;
  late String videoPath;
  late String seekValue;
  late int? videoIndex;
  late double aspectRatio;
  TransformationController transformationController =
      TransformationController();
  ValueNotifier<bool> showControllers = ValueNotifier<bool>(true);

  ValueNotifier<bool> fullScreen = ValueNotifier<bool>(false);
  int delayedVisibility = 3;
  late VideoPlayerController videoPlayerController;

  double brightnessInitialY = 0;

  double previousScale = 1.0;

  Future<void> initVideoPlayer() async {
    emit(VideoControllerInitLoading());

    try {
      videoPlayerController = VideoPlayerController.file(File(videoPath));
      await videoPlayerController.setLooping(true);

      await videoPlayerController.initialize();
      if (speedNotifier.value != 1) {
        await videoPlayerController.setPlaybackSpeed(speedNotifier.value / 10);
      }
      aspectRatio = videoPlayerController.value.aspectRatio;
      emit(VideoControllerInitSuccess());

      await playVideo();
    } catch (e) {
      emit(VideoControllerInitFail(e.toString()));
    }
  }

  Future<void> pauseVideo() async {
    await videoPlayerController.pause();
  }

  Future<void> playVideo() async {
    await videoPlayerController.play();
  }

  Future<void> setVolume(DragUpdateDetails details) async {
    const sensitivity = 0.05;
    double volume = 0.5;
    volume += details.primaryDelta! * sensitivity;
    if (volume > 1.0) volume = 1.0;
    if (volume < 0.0) volume = 0.0;
    videoPlayerController.setVolume(volume);
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      throw 'Failed to set brightness';
    }
  }

  Future<void> changeSpeed(double value) async {
    await videoPlayerController.setPlaybackSpeed(value / 10);
    speedNotifier.value = value;
  }

  Future<void> fastForward() async {
    final Duration newPosition =
        videoPlayerController.value.position + const Duration(seconds: 10);
    await videoPlayerController.seekTo(newPosition);
    seekValue = '+10';
  }

  Future<void> rewind() async {
    final Duration newPosition =
        videoPlayerController.value.position - const Duration(seconds: 10);
    await videoPlayerController.seekTo(newPosition);
    seekValue = '-10';
  }

  Future<void> disposeVideo() async {
    await videoPlayerController.dispose();
  }

  double _previousScale = 1.0;

  void onScaleStart(ScaleStartDetails details) {
    _previousScale = transformationController.value.getMaxScaleOnAxis();
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    double scale = _previousScale * details.scale;
    if (scale < 1.0) {
      // If scaling down beyond initial scale, reset the scale
      transformationController.value = Matrix4.identity();
      return;
    }
    transformationController.value = Matrix4.diagonal3Values(scale, scale, 1.0);
  }

  void onScaleEnd(ScaleEndDetails details) {
    double scale = transformationController.value.getMaxScaleOnAxis();
    if (scale < 1.0) {
      transformationController.value = Matrix4.identity();
    }
  }
}
