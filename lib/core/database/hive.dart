import 'dart:async';

import 'package:hive_flutter/adapters.dart';
import 'package:videoplayer/core/functions/fetch_videos.dart';

abstract class MyHive {
  static final Box videosBox = Hive.box('videos');
  static final Box settingsBox = Hive.box('settings');

  static Future<void> initHive() async {
    await Hive.initFlutter();

    await Hive.openBox('videos');
    await Hive.openBox('settings');
  }

  static Future<void> disposeBoxes() async {
    await videosBox.close();
    //   await settingsBox.close();
  }

  static Future<void> saveToVideosBox() async {
    final result = await fetchVideos();
    if (result.isNotEmpty) {
      if (videosBox.isEmpty) {
        videosBox.addAll(result);
      } else {
        for (String path in result[0]) {
          int index = videosBox.values.toList().indexOf(path);
          videosBox.deleteAt(index);
        }
        for (String path in result[1]) {
          videosBox.add(path);
        }
      }
    }
  }

  static Future<List<String>> searchInBox(String query) async {
    if (query.isEmpty) {
      return [];
    }
    final String searchQuery = query.toLowerCase();
    List<String> result = [];
    for (String element in videosBox.values) {
      String valueInBox = element.split('/').last.toLowerCase();
      if (valueInBox.contains(searchQuery)) {
        result.add(element);
      }
    }
    return result;
  }
  /* static Future<void> computeSaveToVideosBox() async {
    ListAllVideos object = ListAllVideos();
    List<VideoDetails> videos = await object.getAllVideosPath();
    final result = await compute(saveToVideosBox, videos);
    videosBox.addAll(result);
  }*/

  /*static Future<dynamic> saveToVideosBox(List<VideoDetails> videos) async {
    // if (videosBox.isEmpty) {
    List<String> videoPaths = videos.map((video) => video.videoPath).toList();

    List<String> sortedPaths = await compute(sortVideosByDate, videoPaths);
    return sortedPaths;
    //  videosBox.addAll(sortedPaths);
    //  }
    /* else {
      List<String> newVideoPaths =
          videos.map((video) => video.videoPath).toList();
      List<String> existingVideoPaths = List<String>.from(videosBox.values);

      List<String> videosToAdd = newVideoPaths
          .where((path) => !existingVideoPaths.contains(path))
          .toList();
      List<String> videosToRemove = existingVideoPaths
          .where((path) => !newVideoPaths.contains(path))
          .toList();
      if (videosToAdd.isNotEmpty) {
        for (String path in videosToAdd) {
          videosBox.add(path);
        }
      }

      if (videosToRemove.isNotEmpty) {
        for (String path in videosToRemove) {
          int index = videosBox.values.toList().indexOf(path);
          videosBox.deleteAt(index);
        }
      }
    }
  }*/
  }*/
}
