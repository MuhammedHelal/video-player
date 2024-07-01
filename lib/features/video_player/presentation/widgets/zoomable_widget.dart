/*
class GesturesWidget extends StatefulWidget {
  const GesturesWidget({super.key, required this.child});
  final Widget child;
  @override
  State<GesturesWidget> createState() => _GesturesWidgetState();
}

class _GesturesWidgetState extends State<GesturesWidget> {
  final TransformationController _transformationController =
      TransformationController();
  double _previousScale = 1.0;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final VideoCubit videoCubit = BlocProvider.of<VideoCubit>(context);
    final VideoviewCubit videoviewCubit =
        BlocProvider.of<VideoviewCubit>(context);
    return LayoutBuilder(
      builder: (context, constraints) => 
        child: InteractiveViewer(
          panEnabled: false,
          scaleEnabled: false,
          transformationController: _transformationController,
          child: widget.child,
        ),
      ),
    );
  }

  void onScaleStart(ScaleStartDetails details) {
    _previousScale = _transformationController.value.getMaxScaleOnAxis();
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    double scale = _previousScale * details.scale;
    if (scale < 1.0) {
      // If scaling down beyond initial scale, reset the scale
      _transformationController.value = Matrix4.identity();
      return;
    }
    _transformationController.value =
        Matrix4.diagonal3Values(scale, scale, 1.0);
  }

  void onScaleEnd(ScaleEndDetails details) {
    double scale = _transformationController.value.getMaxScaleOnAxis();
    if (scale < 1.0) {
      _transformationController.value = Matrix4.identity();
    }
  }
}
*/