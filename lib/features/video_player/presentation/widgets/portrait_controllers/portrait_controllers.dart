import 'package:flutter/material.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/controllers_black_gradient.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/middle_controllers.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/portrait_controllers/bottom_portrait.dart';
import 'package:videoplayer/features/video_player/presentation/widgets/portrait_controllers/portrait_header.dart';

class PortraitControllers extends StatelessWidget {
  const PortraitControllers({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ControllersBlackGradient(
          isWigetOnTop: true,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: PortraitHeader(),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: MiddleControllers(),
          ),
        ),
        SafeArea(
          child: ControllersBlackGradient(
            isWigetOnTop: false,
            child: PortraitBottom(),
          ),
        ),
      ],
    );
  }
}
