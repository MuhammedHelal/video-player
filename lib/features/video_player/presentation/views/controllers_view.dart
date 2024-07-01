import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/features/video_player/cubits/controllers_cubit/controllers_cubit.dart';
import 'package:videoplayer/features/video_player/cubits/controllers_cubit/controllers_state.dart';
import 'package:videoplayer/features/video_player/presentation/overlays/overlay_alignment.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/landscape_controllers/landscape_controllers.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/portrait_controllers/portrait_controllers.dart';

class ControllersView extends StatelessWidget {
  const ControllersView({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllersCubit controllersCubit =
        BlocProvider.of<ControllersCubit>(context);
    return BlocBuilder<ControllersCubit, ControllersState>(
      builder: (context, state) {
        if (state is ControllersLocked) {
          return OverlayAlignment(
            child: IconButton(
              onPressed: () {
                controllersCubit.unLockController();
              },
              icon: const Icon(
                Icons.lock_open,
                size: 30,
              ),
            ),
          );
        } else {
          final Orientation orientation = MediaQuery.of(context).orientation;

          if (orientation == Orientation.landscape) {
            return BlocProvider.value(
              value: controllersCubit,
              child: const LandscapeControllers(),
            );
          } else {
            return BlocProvider.value(
              value: controllersCubit,
              child: const PortraitControllers(),
            );
          }
        }
      },
    );
  }
}
