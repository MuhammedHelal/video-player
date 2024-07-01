import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/core/database/hive.dart';
import 'package:videoplayer/features/browse_videos/all_videos_cubit/all_videos_state.dart';

class AllVideosCubit extends Cubit<AllVideosState> {
  AllVideosCubit() : super(VideosInitial());
  Future<void> sortBySize() async {}

  Future<void> sortByDate() async {
    //   List<VideoModel> videosByDate = [];

    // List<String> videos = List<String>.from(MyHive.videosBox.values);
    //   print(videos);
    /* videos.forEach(
      (element) async {
        DateTime? date = await getLastModified(element);
        videosByDate.add(VideoModel(videoPath: element, videoDate: date));
      },
    ); */
    // videosByDate.sort((a, b) => b.videoDate!.compareTo(a.videoDate!));
    // print(videosByDate);
    emit(SortByDateSuccess(List<String>.from(MyHive.videosBox.values)));
  }

  Future<void> sortByDuration() async {}

  Future<void> saveToVideosBox() async {
    //  await Permission.manageExternalStorage.request();
    // await Permission.storage.request();

    final previousLength = MyHive.videosBox.length;
    await MyHive.saveToVideosBox();
    final nowLength = MyHive.videosBox.length;
    if (previousLength != nowLength) {
      emit(UpdateDatabaseSuccess());
    }
  }
}
