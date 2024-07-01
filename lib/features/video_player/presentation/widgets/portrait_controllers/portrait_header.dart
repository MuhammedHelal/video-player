import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:videoplayer/features/video_player/cubits/controllers_cubit/controllers_cubit.dart';

class PortraitHeader extends StatelessWidget {
  const PortraitHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final ControllersCubit controllersCubit =
        BlocProvider.of<ControllersCubit>(context);
    final videoName =
        VideoDetails(controllersCubit.videoCubit.videoPath).videoName;
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        Expanded(
          child: Text(
            videoName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}
