import 'package:flutter/material.dart';

class BlackBackground extends StatelessWidget {
  const BlackBackground(
      {super.key, required this.child, required this.isOverlay});
  final Widget child;
  final bool isOverlay;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isOverlay ? 70 : null,
      height: isOverlay ? 70 : null,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isOverlay ? Colors.black45 : Colors.black26,
        borderRadius:
            isOverlay ? BorderRadius.circular(20) : BorderRadius.circular(50),
      ),
      child: child,
    );
  }
}
