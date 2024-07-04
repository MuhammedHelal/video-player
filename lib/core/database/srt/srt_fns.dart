import 'dart:io';

import 'package:flutter/foundation.dart';

List<String> srtFiles = [];

Future<List> fetchSrtFiles() async {
  final dir = Directory('/storage/emulated/0/');
  if (await dir.exists()) {
    return await compute(_getSrtFiles, dir);
  }
  return [];
}

Future<List<String>> _getSrtFiles(Directory dir) async {
  List<String> srtFiles = [];
  try {
    await for (var entity in dir.list(recursive: false, followLinks: false)) {
      if (entity is File && entity.path.endsWith('.srt')) {
        srtFiles.add(entity.path);
      }

      if (entity is Directory) {
        if (_isAllowedDirectory(entity.path)) {
          try {
            List<String> subFiles = await compute(_getSrtFiles, entity);
            srtFiles.addAll(subFiles);
          } catch (e) {
            print('Error while listing directory ${entity.path}: $e');
          }
        }
      }
    }
  } catch (e) {
    print('Error while listing directory ${dir.path}: $e');
  }
  return srtFiles;
}

bool _isAllowedDirectory(String path) {
  final segments = path.split('/');
  return !segments.any(
    (segment) =>
        segment.contains('Android') ||
        segment.contains('android') ||
        segment.startsWith('.'),
  );
}
