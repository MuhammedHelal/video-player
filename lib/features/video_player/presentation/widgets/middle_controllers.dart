import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:videoplayer/core/services/service_locator.dart';
import 'package:videoplayer/core/theme/widgets/text_theme.dart';
import 'package:videoplayer/features/video_player/cubits/controllers_cubit/controllers_cubit.dart';
import 'package:videoplayer/features/video_player/cubits/videoview_cubit/videoview_cubit.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/change_speed_widget.dart';
import 'package:videoplayer/features/video_player/presentation/overlays/overlay_black_background.dart';

class MiddleControllers extends StatelessWidget {
  const MiddleControllers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ControllersCubit controllersCubit =
        BlocProvider.of<ControllersCubit>(context);
    final VideoviewCubit videoviewCubit = getIt<VideoviewCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlackBackground(
          isOverlay: false,
          child: IconButton(
            onPressed: () {
              videoviewCubit.showControllers();
              showDialog(
                context: context,
                builder: (context) => ChangeSpeedWidget(
                  videoCubit: controllersCubit.videoCubit,
                ),
              );
            },
            icon: Column(
              children: [
                const Icon(Icons.speed),
                const Gap(2),
                ValueListenableBuilder(
                  valueListenable: controllersCubit.videoCubit.speedNotifier,
                  builder: (context, value, child) {
                    return Text(
                      '${(controllersCubit.videoCubit.speedNotifier.value / 10).toStringAsFixed(2)}x',
                      style: MyTextTheme.durationTextStyle,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: BlackBackground(
            isOverlay: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    videoviewCubit.showControllers();

                    final Orientation orientation =
                        MediaQuery.of(context).orientation;
                    controllersCubit.orientationNotifier.value =
                        !controllersCubit.orientationNotifier.value;
                    if (controllersCubit.orientationNotifier.value) {
                      if (orientation == Orientation.landscape) {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeLeft,
                          DeviceOrientation.landscapeRight,
                        ]);
                      } else {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitDown,
                          DeviceOrientation.portraitUp,
                        ]);
                      }
                    } else {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                        DeviceOrientation.portraitDown,
                        DeviceOrientation.portraitUp,
                      ]);
                    }
                  },
                  icon: ValueListenableBuilder(
                    valueListenable: controllersCubit.orientationNotifier,
                    builder: (context, value, child) {
                      if (value) {
                        return const Icon(
                          Icons.screen_lock_landscape,
                        );
                      } else {
                        return const Icon(
                          Icons.screen_rotation,
                        );
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controllersCubit.lockController();
                  },
                  icon: const Icon(Icons.lock),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
