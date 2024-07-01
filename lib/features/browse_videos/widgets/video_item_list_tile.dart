import 'package:flutter/material.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';
import 'package:videoplayer/core/consts/colors.dart';
import 'package:videoplayer/core/functions/play_video.dart';
import 'package:path/path.dart' as path;

class VideoListTile extends StatelessWidget {
  const VideoListTile({
    super.key,
    required this.videoDetails,
    this.index,
  });

  final VideoDetails videoDetails;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {
          playVideo(
            context: context,
            videoPath: videoDetails.videoPath,
            index: index,
          );
        },
        title: Text(
          path.basenameWithoutExtension(videoDetails.videoName),
          maxLines: 2,
          softWrap: true,
          style: textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          videoDetails.videoSize,
          style: textTheme.labelMedium,
        ),
        leading: ThumbnailTile(
          thumbnailController: videoDetails.thumbnailController,
          height: 300,
          width: 100,
        ),
      ),
    );
  }
}
