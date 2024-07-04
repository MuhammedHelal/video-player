import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:videoplayer/core/database/srt/srt_fns.dart';
import 'package:videoplayer/core/functions/fetch_videos.dart';

abstract class MyHive {
  static final Box videosBox = Hive.box('videos');
  static final Box srtBox = Hive.box('srt');

  static Future<void> initHive() async {
    await Hive.initFlutter();

    await Hive.openBox('videos');
    await Hive.openBox('srt');
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

  static Future<void> saveToSrtBox() async {
    final List<dynamic> result = await fetchSrtFiles();
    if (srtBox.isEmpty) {
      srtBox.addAll(result);
    } else {
      await srtBox.clear();
      await srtBox.addAll(result);
    }
  }

  static Future<String?> searchInSrtBox(String query) async {
    String? bestMatch;
    double highestSimilarity = 0.0;

    for (String file in srtBox.values) {
      double similarity = query.similarityTo(file);
      if (similarity > highestSimilarity) {
        highestSimilarity = similarity;
        bestMatch = file;
      }
    }
    print('Best match: $bestMatch, similarity: $highestSimilarity');
    if (highestSimilarity > 0.4) {
      return bestMatch;
    }
    return null;
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
}
