import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/features/video_player/cubits/video_cubit/video_cubit.dart';
import 'package:videoplayer/features/video_player/cubits/videoview_cubit/videoview_cubit.dart';
import 'package:videoplayer/features/video_player/presentation/overlays/overlay_alignment.dart';

class SeekOverlay extends StatelessWidget {
  const SeekOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final VideoCubit videoCubit = BlocProvider.of<VideoCubit>(context);

    return BlocBuilder<VideoviewCubit, VideoviewState>(
      builder: (context, state) {
        if (state is Seek) {
          return OverlayAlignment(
            child: Text(
              '${videoCubit.seekValue}sec',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
