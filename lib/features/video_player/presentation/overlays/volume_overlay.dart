import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/features/video_player/cubits/videoview_cubit/videoview_cubit.dart';
import 'package:videoplayer/features/video_player/presentation/overlays/overlay_alignment.dart';

class VolumeOverlay extends StatelessWidget {
  const VolumeOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final VideoviewCubit videoviewCubit =
        BlocProvider.of<VideoviewCubit>(context);

    return BlocBuilder<VideoviewCubit, VideoviewState>(
      builder: (context, state) {
        if (state is ChangeVolume) {
          return OverlayAlignment(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.volume_up_rounded),
                Text(
                  '${(videoviewCubit.volume * 100).round()}%',
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
