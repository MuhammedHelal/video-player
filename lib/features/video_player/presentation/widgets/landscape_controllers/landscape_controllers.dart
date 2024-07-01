import 'package:flutter/material.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/controllers_black_gradient.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/landscape_controllers/bottom_landscape.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/landscape_controllers/header_landscape.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/middle_controllers.dart';

class LandscapeControllers extends StatelessWidget {
  const LandscapeControllers({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ControllersBlackGradient(
          isWigetOnTop: true,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: LandscapeHeader(),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: MiddleControllers(),
          ),
        ),
        ControllersBlackGradient(
          isWigetOnTop: false,
          child: SafeArea(
            child: LandscapeBottom(),
          ),
        ),
      ],
    );
  }
}
