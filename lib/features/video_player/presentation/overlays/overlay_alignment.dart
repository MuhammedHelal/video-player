import 'package:flutter/material.dart';
import 'package:videoplayer/features/video_player/presentation/overlays/overlay_black_background.dart';

class OverlayAlignment extends StatelessWidget {
  const OverlayAlignment({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: BlackBackground(
        isOverlay: false,
        child: child,
      ),
    );
  }
}
