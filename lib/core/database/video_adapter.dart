


/*
class VideoAdapter extends TypeAdapter<VideoDetails> {
  @override
  final int typeId = 0;

  @override
  VideoDetails read(BinaryReader reader) {
    final videoPath = reader.readString();
    final videoDate = reader.readString();
    return VideoDetails();
  }

  @override
  void write(BinaryWriter writer, VideoModel obj) {
    writer.writeString(obj.videoPath);
    writer.writeString(obj.videoDate);
  }
}
*/