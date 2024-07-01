import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/core/services/service_locator.dart';
import 'package:videoplayer/features/video_player/cubits/controllers_cubit/controllers_cubit.dart';
import 'package:videoplayer/features/video_player/cubits/videoview_cubit/videoview_cubit.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/play_pause_icon_button.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/video_progress.dart';

class LandscapeBottom extends StatelessWidget {
  const LandscapeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllersCubit controllersCubit =
        BlocProvider.of<ControllersCubit>(context);

    return Column(
      children: [
        const VideoProgress(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlayButtons(
                controllersCubit: controllersCubit,
              ),
              IconButton(
                onPressed: () {
                  getIt<VideoviewCubit>().showOrHideController();

                  getIt<Floating>().enable();
                  //   getIt<VideoviewCubit>().showController.value = false;
                },
                icon: const Icon(Icons.picture_in_picture_alt),
              ),
              /* StatefulBuilder(
                builder: (context, setState) {
                  bool isLooping = videoCubit.videoPlayerController.value.isLooping;
                  return IconButton(
                    onPressed: () {
                      setState(
                        () {
                          videoCubit.videoPlayerController.setLooping(!isLooping);
                        },
                      );
                    },
                    icon: Icon(isLooping ? Icons.loop : Icons.lock_open),
                  );
                },
              ),*/
            ],
          ),
        ),
      ],
    );
  }
}

class PlayButtons extends StatelessWidget {
  const PlayButtons({
    super.key,
    required this.controllersCubit,
  });

  final ControllersCubit controllersCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: PlayPauseIconButton(),
        ),
        if (controllersCubit.videoCubit.videoIndex != null)
          IconButton(
            onPressed: () async {
              controllersCubit.calculateNextIndex();

              await controllersCubit.playNextOrPreviousVideo();
            },
            icon: const Icon(
              Icons.skip_previous_rounded,
              size: 35,
            ),
          )
        else
          const SizedBox.shrink(),
        if (controllersCubit.videoCubit.videoIndex != null)
          IconButton(
            onPressed: () async {
              controllersCubit.calculatePreviousIndex();
              await controllersCubit.playNextOrPreviousVideo();
            },
            icon: const Icon(
              Icons.skip_next_rounded,
              size: 35,
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
