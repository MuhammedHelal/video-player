import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/features/video_player/cubits/videoview_cubit/videoview_cubit.dart';

class HotizontalSeekOverlay extends StatelessWidget {
  const HotizontalSeekOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoviewCubit, VideoviewState>(
      builder: (context, state) {
        if (state is HorizontalSeek) {
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${state.duration} / ${state.totalDuration}',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
