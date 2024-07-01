import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:videoplayer/core/database/hive.dart';
import 'package:videoplayer/features/browse_videos/widgets/video_item_list_tile.dart';

class VideoItem extends StatefulWidget {
  const VideoItem({
    super.key,
    required this.index,
  });
  final int index;
  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  bool isError = false;
  bool isLoading = true;
  late String path;
  final GlobalKey slidableKey = GlobalKey();
  bool isDismissed = false;
  late VideoDetails videoDetails;
  @override
  void initState() {
    path = MyHive.videosBox.getAt(widget.index);
    getVideoDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isError || isDismissed) {
      return const SizedBox.shrink();
      /*} else if (isLoading) {
      return const CircularProgressIndicator();*/
    } else {
      return Slidable(
        key: slidableKey,
        startActionPane: ActionPane(
          extentRatio: 0.6,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                await confirmDelete(context);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) async {
                await FlutterShare.shareFile(
                  filePath: path,
                  fileType: 'video/*',
                  title: videoDetails.videoName,
                );
              },
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: 'Share',
            ),
          ],
        ),
        child: VideoListTile(
          videoDetails: videoDetails,
          index: widget.index,
        ),
      );
    }
  }

  Future<dynamic> confirmDelete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Delete?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Click confirm to delete',
              ),
              const Gap(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      setState(() {
                        isDismissed = true;
                      });
                      await deleteFile();
                    },
                    child: const Text('Delete'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> deleteFile() async {
    try {
      File file = File(path);
      if (file.existsSync()) {
        await file.delete();
        await MyHive.videosBox.deleteAt(widget.index);
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }

  void getVideoDetails() {
    try {
      videoDetails = VideoDetails(path);
    } catch (e) {
      setState(() {
        isError = true;
      });
    }
  }
}
