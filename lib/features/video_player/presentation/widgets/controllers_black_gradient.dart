import 'package:flutter/material.dart';

class ControllersBlackGradient extends StatelessWidget {
  const ControllersBlackGradient(
      {super.key, required this.isWigetOnTop, required this.child});
  final bool isWigetOnTop;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [
            Colors.black54,
            Colors.black12,
          ],
          begin: isWigetOnTop ? Alignment.topCenter : Alignment.bottomCenter,
          end: isWigetOnTop ? Alignment.bottomCenter : Alignment.topCenter,
        ),
      ),
      child: child,
    );
  }
}
