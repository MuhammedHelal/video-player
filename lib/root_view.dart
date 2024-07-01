import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:videoplayer/core/functions/play_video.dart';
import 'package:videoplayer/core/services/service_locator.dart';
import 'package:videoplayer/cubit/root_cubit.dart';
import 'package:videoplayer/features/browse_videos/all_videos_cubit/all_videos_cubit.dart';
import 'package:videoplayer/features/browse_videos/views/browse_videos_view.dart';
import 'package:videoplayer/permission_view.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  final RootCubit rootCubit = getIt<RootCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await _handleIntents();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootCubit, RootState>(
      builder: (context, state) {
        if (state is PermissionDenied || state is PermissionPermenantDenied) {
          return BlocProvider.value(
            value: rootCubit,
            child: const PermissionView(),
          );
        } else if (state is PermissionGranted) {
          return Padding(
            padding: EdgeInsets.zero,
            child: BlocProvider(
              create: (context) => AllVideosCubit()..saveToVideosBox(),
              child: const BrowseVideosView(),
            ),
          );
        } else {
          return BlocProvider(
            create: (context) => AllVideosCubit(),
            child: const BrowseVideosView(),
          );

          /*    BlocProvider(
            create: (context) => AllVideosCubit(),
            child: const Padding(
              padding: EdgeInsets.all(0.0),
              child: BrowseVideosView(),
            ),
          );*/
        }
      },
    );
  }

  Future<void> _handleIntents() async {
    final ReceiveSharingIntent receiveSharingIntent =
        ReceiveSharingIntent.instance;
    receiveSharingIntent.getMediaStream().listen((List<SharedMediaFile> value) {
      if (value.isNotEmpty) {
        playVideo(
          context: context,
          videoPath: value.first.path,
        );
      }
    }, onError: (err) {
      //  print("getMediaStream error: $err");
    });
    receiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      if (value.isNotEmpty) {
        playVideo(
          context: context,
          videoPath: value.first.path,
        );
      }
    });
  }
}
