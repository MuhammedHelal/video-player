import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/core/consts/colors.dart';
import 'package:videoplayer/core/services/service_locator.dart';
import 'package:videoplayer/features/video_player/cubits/controllers_cubit/controllers_cubit.dart';
import 'package:videoplayer/features/video_player/cubits/videoview_cubit/videoview_cubit.dart';

class PlayPauseIconButton extends StatelessWidget {
  const PlayPauseIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ControllersCubit controllersCubit =
        BlocProvider.of<ControllersCubit>(context);
    final VideoviewCubit videoviewCubit = getIt<VideoviewCubit>();

    return ValueListenableBuilder(
      valueListenable: controllersCubit.videoCubit.videoPlayerController,
      builder: (context, value, child) {
        if (value.isPlaying || value.isBuffering) {
          return IconButton(
            onPressed: () async {
              videoviewCubit.showControllers();

              await controllersCubit.videoCubit.pauseVideo();
            },
            icon: const ControllersBorderContainer(
              child: Icon(
                Icons.pause,
                size: 45,
              ),
            ),
          );
        } else {
          return IconButton(
            onPressed: () async {
              videoviewCubit.showControllers();

              await controllersCubit.videoCubit.playVideo();
            },
            icon: const ControllersBorderContainer(
              child: Icon(
                Icons.play_circle,
                size: 45,
              ),
            ),
          );
        }
      },
    );
  }
}

class ControllersBorderContainer extends StatelessWidget {
  const ControllersBorderContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: child,
    );
  }
}
