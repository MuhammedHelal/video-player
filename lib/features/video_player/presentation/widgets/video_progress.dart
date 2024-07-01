import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/core/consts/colors.dart';
import 'package:videoplayer/core/functions/format_duration.dart';
import 'package:videoplayer/core/theme/widgets/text_theme.dart';
import 'package:videoplayer/features/video_player/cubits/controllers_cubit/controllers_cubit.dart';

class VideoProgress extends StatefulWidget {
  const VideoProgress({super.key});
  @override
  State<VideoProgress> createState() => _VideoProgressState();
}

class _VideoProgressState extends State<VideoProgress> {
  late final ControllersCubit controllersCubit;
  double _progress = 0.0;
  @override
  void initState() {
    super.initState();
    controllersCubit = BlocProvider.of<ControllersCubit>(context);
    _progress = controllersCubit
            .videoCubit.videoPlayerController.value.position.inSeconds /
        controllersCubit
            .videoCubit.videoPlayerController.value.duration.inSeconds;

    controllersCubit.videoCubit.videoPlayerController
        .addListener(_updateProgress);
  }

  @override
  void dispose() {
    controllersCubit.videoCubit.videoPlayerController
        .removeListener(_updateProgress);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 9),
          child: GestureDetector(
            onTap: () {
              setState(() {
                controllersCubit.onTappedTotalDuration =
                    !controllersCubit.onTappedTotalDuration;
              });
            },
            child: Text(
              controllersCubit.onTappedTotalDuration
                  ? '${formatDuration(getDuration())}/-${formatDuration(getTotalDuration())}'
                  : '${formatDuration(getDuration())}/${formatDuration(getTotalDuration())}',
              style: MyTextTheme.durationTextStyle,
            ),
          ),
        ),
        SliderTheme(
          data: const SliderThemeData(
            trackHeight: 7,
            allowedInteraction: SliderInteraction.tapOnly,
          ),
          child: Slider(
            inactiveColor: Colors.white.withOpacity(0.9),
            thumbColor: primaryColor,
            min: 0,
            value: _progress,
            onChanged: (value) async {
              double percentage = value;

              Duration position = controllersCubit
                      .videoCubit.videoPlayerController.value.duration *
                  percentage;
              await controllersCubit.videoCubit.videoPlayerController
                  .seekTo(position);
            },
          ),
        ),
      ],
    );
  }

  void _updateProgress() {
    if (mounted) {
      setState(() {
        _progress = controllersCubit
                .videoCubit.videoPlayerController.value.position.inSeconds /
            controllersCubit
                .videoCubit.videoPlayerController.value.duration.inSeconds;
      });
    }
  }

  Duration getTotalDuration() {
    if (controllersCubit.onTappedTotalDuration) {
      Duration onTappedTotalDuration =
          (controllersCubit.videoCubit.videoPlayerController.value.duration -
              controllersCubit.videoCubit.videoPlayerController.value.position);

      return onTappedTotalDuration;
    } else {
      Duration totalDuration =
          controllersCubit.videoCubit.videoPlayerController.value.duration;

      return totalDuration;
    }
  }

  Duration getDuration() {
    Duration duration =
        controllersCubit.videoCubit.videoPlayerController.value.position;

    return duration;
  }
}
