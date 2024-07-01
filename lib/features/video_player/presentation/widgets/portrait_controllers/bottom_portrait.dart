import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:videoplayer/core/services/service_locator.dart';
import 'package:videoplayer/features/video_player/cubits/controllers_cubit/controllers_cubit.dart';
import 'package:videoplayer/features/video_player/cubits/videoview_cubit/videoview_cubit.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/play_pause_icon_button.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/video_progress.dart';

class PortraitBottom extends StatelessWidget {
  const PortraitBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllersCubit controllersCubit =
        BlocProvider.of<ControllersCubit>(context);
    final VideoviewCubit videoviewCubit = getIt<VideoviewCubit>();

    return Column(
      children: [
        const VideoProgress(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FillButton(
                controllersCubit: controllersCubit,
                videoviewCubit: videoviewCubit,
              ),
              PlayButtons(
                controllersCubit: controllersCubit,
              ),
              IconButton(
                onPressed: () {
                  getIt<VideoviewCubit>().showOrHideController();

                  getIt<Floating>().enable();
                },
                icon: const Icon(Icons.picture_in_picture_alt),
              ),
            ],
          ),
        ),
        const Gap(20),
      ],
    );
  }
}

class FillButton extends StatelessWidget {
  const FillButton({
    super.key,
    required this.controllersCubit,
    required this.videoviewCubit,
  });

  final ControllersCubit controllersCubit;
  final VideoviewCubit videoviewCubit;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controllersCubit.videoCubit.fullScreen,
      builder: (context, value, child) {
        return IconButton(
          onPressed: () {
            videoviewCubit.showControllers();
            controllersCubit.videoCubit.fullScreen.value =
                !controllersCubit.videoCubit.fullScreen.value;
          },
          icon: controllersCubit.videoCubit.fullScreen.value
              ? const Icon(
                  Icons.fullscreen_exit,
                )
              : const Icon(
                  Icons.fullscreen,
                ),
        );
      },
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
      mainAxisSize: MainAxisSize.min,
      children: [
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
        const PlayPauseIconButton(),
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
