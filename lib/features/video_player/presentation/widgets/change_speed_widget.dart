import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:videoplayer/features/video_player/cubits/video_cubit/video_cubit.dart';

class ChangeSpeedWidget extends StatefulWidget {
  const ChangeSpeedWidget({
    super.key,
    required this.videoCubit,
  });

  final VideoCubit videoCubit;

  @override
  State<ChangeSpeedWidget> createState() => _ChangeSpeedWidgetState();
}

class _ChangeSpeedWidgetState extends State<ChangeSpeedWidget> {
  @override
  Widget build(BuildContext context) {
    double speed = widget.videoCubit.speedNotifier.value;

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(25),
          const Text('Change Speed'),
          const Gap(10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: SliderTheme(
              data: const SliderThemeData(
                trackHeight: 20,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 15.0,
                ), // Increase thumb size
              ),
              child: Slider(
                value: speed,
                min: 7.5,
                max: 25,
                divisions: 7,
                label: (speed / 10).toStringAsFixed(2),
                onChanged: (value) async {
                  await widget.videoCubit.changeSpeed(value);
                  setState(() {});
                },
              ),
            ),
          ),
          const Gap(15),
          Text(
            '${(widget.videoCubit.speedNotifier.value / 10).toStringAsFixed(2)}x',
          ),
          const Gap(25),
        ],
      ),
    );
  }
}
