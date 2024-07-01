import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/features/video_player/cubits/controllers_cubit/controllers_cubit.dart';
import 'package:videoplayer/features/video_player/cubits/video_cubit/video_cubit.dart';
import 'package:videoplayer/features/video_player/cubits/video_cubit/video_state.dart';
import 'package:videoplayer/features/video_player/cubits/videoview_cubit/videoview_cubit.dart';
import 'package:videoplayer/features/video_player/presentation/views/controllers_view.dart';
import 'package:videoplayer/features/video_player/presentation/views/video_player_view.dart';
import 'package:videoplayer/features/video_player/presentation/overlays/brightness_overlay.dart';
import 'package:videoplayer/features/video_player/presentation/overlays/hotizontal_seek_overlay.dart';
import 'package:videoplayer/features/video_player/presentation/overlays/seek_overlay.dart';
import 'package:videoplayer/features/video_player/presentation/overlays/volume_overlay.dart';

class VideoView extends StatelessWidget {
  const VideoView({super.key});
  @override
  Widget build(BuildContext context) {
    final VideoCubit videoCubit = BlocProvider.of<VideoCubit>(context);
    final VideoviewCubit videoviewCubit =
        BlocProvider.of<VideoviewCubit>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    final ControllersCubit controllersCubit = ControllersCubit(videoCubit);
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) {
        if (state is VideoControllerInitFail) {
          return const VideoControllerInitFailView();
        } else if (state is VideoControllerInitLoading) {
          return const VideoControllerInitLoadingView();
        } else {
          return Scaffold(
            backgroundColor: Colors.black,
            body: LayoutBuilder(
              builder: (
                context,
                constraints,
              ) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    const Center(child: VideoPlayerView()),
                    const HotizontalSeekOverlay(),
                    const BrightnessOverlay(),
                    const VolumeOverlay(),
                    const SeekOverlay(),
                    GestureDetector(
                      onDoubleTapDown: (details) async {
                        if (controllersCubit.isControllersLocked) return;
                        if (details.localPosition.dx <=
                            constraints.maxWidth * 0.2) {
                          await videoCubit.rewind();
                          videoviewCubit.showSeekOverlay();
                        } else if (details.localPosition.dx >=
                            constraints.maxWidth * 0.8) {
                          await videoCubit.fastForward();
                          videoviewCubit.showSeekOverlay();
                        } else {
                          if (videoCubit
                              .videoPlayerController.value.isPlaying) {
                            await videoCubit.videoPlayerController.pause();
                          } else {
                            await videoCubit.videoPlayerController.play();
                          }
                        }
                      },
                      onHorizontalDragUpdate: (details) async {
                        if (controllersCubit.isControllersLocked) return;

                        await videoviewCubit.onHorizontalSeekUpdate(
                          details: details,
                          videoPlayerController:
                              videoCubit.videoPlayerController,
                          width: MediaQuery.of(context).size.width,
                        );
                      },
                      onHorizontalDragEnd: (details) async {
                        if (controllersCubit.isControllersLocked) return;

                        await videoviewCubit.onHorizontalSeekEnd(
                          videoPlayerController:
                              videoCubit.videoPlayerController,
                        );
                      },
                      onVerticalDragStart: (details) {
                        if (controllersCubit.isControllersLocked) return;

                        if (details.localPosition.dx <=
                                constraints.maxWidth * 0.2 ||
                            details.localPosition.dx >=
                                constraints.maxWidth * 0.8) {
                          videoviewCubit.initialY = details.localPosition.dy;
                        }
                      },
                      onVerticalDragUpdate: (details) async {
                        if (controllersCubit.isControllersLocked) return;

                        if (details.localPosition.dx <=
                            constraints.maxWidth * 0.2) {
                          await videoviewCubit
                              .onLeftVerticalDragUpdate(details);
                        }
                        if (details.localPosition.dx >=
                            constraints.maxWidth * 0.8) {
                          await videoviewCubit
                              .onRightVerticalDragUpdate(details);
                        }
                      },
                      onTap: () {
                        videoviewCubit.showOrHideController();
                      },
                    ),
                    BlocBuilder<VideoviewCubit, VideoviewState>(
                      builder: (context, state) {
                        if (state is ShowControllers) {
                          return BlocProvider.value(
                            value: controllersCubit,
                            child: const ControllersView(),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}

class VideoControllerInitLoadingView extends StatelessWidget {
  const VideoControllerInitLoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class VideoControllerInitFailView extends StatelessWidget {
  const VideoControllerInitFailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Error initializing video',
        style: TextStyle(
          color: Colors.red,
          fontSize: 30,
        ),
      ),
    );
  }
}
