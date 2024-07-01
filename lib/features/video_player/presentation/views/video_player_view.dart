import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/features/video_player/cubits/video_cubit/video_cubit.dart';

class VideoPlayerView extends StatelessWidget {
  const VideoPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    final VideoCubit videoCubit = BlocProvider.of<VideoCubit>(context);
    double fullScreenAspectRatio =
        MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;

    return PopScope(
      onPopInvoked: (didPop) async {
        await videoCubit.disposeVideo();
        Future.delayed(
          const Duration(seconds: 1),
          () {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
              SystemUiOverlay.bottom,
              SystemUiOverlay.top,
            ]);
          },
        );
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ]);
      },
      child: ValueListenableBuilder(
        valueListenable: videoCubit.fullScreen,
        builder: (context, value, child) {
          return AspectRatio(
            aspectRatio: value ? fullScreenAspectRatio : videoCubit.aspectRatio,
            child: VideoPlayer(
              videoCubit.videoPlayerController,
            ),
          );
        },
      ),
    );
  }
}
