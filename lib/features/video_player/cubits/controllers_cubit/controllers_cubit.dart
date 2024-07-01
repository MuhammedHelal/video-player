import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/core/database/hive.dart';
import 'package:videoplayer/core/services/service_locator.dart';
import 'package:videoplayer/features/video_player/cubits/controllers_cubit/controllers_state.dart';
import 'package:videoplayer/features/video_player/cubits/video_cubit/video_cubit.dart';
import 'package:videoplayer/features/video_player/cubits/videoview_cubit/videoview_cubit.dart';

class ControllersCubit extends Cubit<ControllersState> {
  ControllersCubit(this.videoCubit) : super(ControllersInitial());
  final VideoCubit videoCubit;
  bool onTappedTotalDuration = false;
  ValueNotifier orientationNotifier = ValueNotifier<bool>(false);
  bool isControllersLocked = false;
  void lockController() {
    emit(ControllersLocked());
    isControllersLocked = true;
    getIt<VideoviewCubit>().showOrHideController();
  }

  void unLockController() async {
    emit(ControllersUnLocked());
    isControllersLocked = false;

    getIt<VideoviewCubit>().showControllers();
  }

  void onHorizontalDragUpdateSeek(var details,
      {required BuildContext context}) {
    // showController.value = true;
    // timer.cancel();
    double tapPosition = details.localPosition.dx;
    double totalWidth = context.size!.width;

    double percentage = tapPosition / totalWidth;

    Duration position =
        videoCubit.videoPlayerController.value.duration * percentage;
    videoCubit.videoPlayerController.seekTo(position);
    // setTimer();
  }

  Future<void> playNextOrPreviousVideo() async {
    await videoCubit.disposeVideo();
    videoCubit.videoPath = MyHive.videosBox.getAt(videoCubit.videoIndex!);

    await videoCubit.initVideoPlayer();
  }

  void calculatePreviousIndex() {
    final int noOfVideos = MyHive.videosBox.length;

    if (videoCubit.videoIndex == 0) {
      videoCubit.videoIndex = noOfVideos - 1;
    } else {
      videoCubit.videoIndex = videoCubit.videoIndex! - 1;
    }
  }

  void calculateNextIndex() {
    final int noOfVideos = MyHive.videosBox.length;

    if (noOfVideos - 1 == videoCubit.videoIndex) {
      videoCubit.videoIndex = 0;
    } else {
      videoCubit.videoIndex = videoCubit.videoIndex! + 1;
    }
  }
}
