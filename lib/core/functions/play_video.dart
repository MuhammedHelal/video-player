import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/core/services/service_locator.dart';
import 'package:videoplayer/features/video_player/cubits/video_cubit/video_cubit.dart';
import 'package:videoplayer/features/video_player/cubits/videoview_cubit/videoview_cubit.dart';
import 'package:videoplayer/features/video_player/presentation/views/video_view.dart';

void playVideo({
  required BuildContext context,
  required String videoPath,
  int? index,
}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<VideoviewCubit>(),
          ),
          BlocProvider(
            create: (context) => VideoCubit()
              ..videoPath = videoPath
              ..videoIndex = index
              ..initVideoPlayer(),
          ),
        ],
        child: const VideoView(),
      ),
    ),
  );
}
