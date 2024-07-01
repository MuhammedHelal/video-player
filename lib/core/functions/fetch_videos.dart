import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:videoplayer/core/database/hive.dart';

Future<List> fetchVideos() async {
  Directory storageDir = Directory('/storage/emulated/0/');
  if (storageDir.existsSync()) {
    final videos = await compute(_getVideosFiles, storageDir);

    if (videos.isNotEmpty) {
      if (MyHive.videosBox.isEmpty) {
        final result = await compute(sortVideosByDate, videos);
        return result;
      } else {
        final List<String> currentVideos =
            MyHive.videosBox.values.toList().cast();
        final result = await compute(updateVideoPaths, [currentVideos, videos]);
        return result;
      }
    } else {
      return [];
    }
  } else {
    return [];
  }
}

Future<List<String>> _getVideosFiles(Directory dir) async {
  List<String> videosFiles = [];
  try {
    await for (var entity in dir.list(recursive: false, followLinks: false)) {
      if (entity is File &&
          _isAllowedFile(entity.path) &&
          isVideo(entity.path)) {
        videosFiles.add(entity.path);
      }
      if (entity is Directory) {
        if (_isAllowedDirectory(entity.path)) {
          try {
            List<String> subFiles = await _getVideosFiles(entity);
            videosFiles.addAll(subFiles);
          // ignore: empty_catches
          } catch (e) {}
        }
      }
    }
  // ignore: empty_catches
  } catch (e) {}
  return videosFiles;
}

bool isVideo(String path) {
  for (var element in videoFormats) {
    if (path.endsWith(element)) {
      return true;
    } else {
      continue;
    }
  }
  return false;
}

const List<String> videoFormats = [
  ".mp4",
  ".mpeg",
  ".webm",
  ".avi",
  ".mkv",
  ".mov",
  ".wmv",
  ".flv",
  ".mpg",
  ".3gp",
  ".ogv"
];
bool _isAllowedDirectory(String path) {
  if (path.contains('Android') ||
      path.contains('android') ||
      path.split('/').any(
            (element) => element.startsWith('.'),
          )) {
    return false;
  } else {
    return true;
  }
}

bool _isAllowedFile(String path) {
  if (path.split('/').last.startsWith('.')) {
    return false;
  } else {
    return true;
  }
}

Future<List<String>> sortVideosByDate(List<String> videoPaths) async {
  List<MapEntry<String, DateTime>> videosWithDates = [];

  await Future.forEach(videoPaths, (String path) async {
    File file = File(path);
    DateTime lastModified = await file.lastModified();
    videosWithDates.add(MapEntry(path, lastModified));
  });

  videosWithDates.sort((a, b) => a.value.compareTo(b.value));

  List<String> sortedPaths = videosWithDates.map((entry) => entry.key).toList();

  return sortedPaths;
}

updateVideoPaths(List<List<String>> videos) {
  List<String> existingVideoPaths = videos[0];

  List<String> newVideoPaths = videos[1];

  List<String> videosToAdd = newVideoPaths
      .where((path) => !existingVideoPaths.contains(path))
      .toList();
  List<String> videosToRemove = existingVideoPaths
      .where((path) => !newVideoPaths.contains(path))
      .toList();

  return [videosToRemove, videosToAdd];
}
