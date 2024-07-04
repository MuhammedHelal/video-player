import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:videoplayer/core/consts/colors.dart';
import 'package:videoplayer/core/services/service_locator.dart';
import 'package:videoplayer/features/video_player/cubits/controllers_cubit/controllers_cubit.dart';
import 'package:videoplayer/features/video_player/cubits/videoview_cubit/videoview_cubit.dart';

class LandscapeHeader extends StatelessWidget {
  const LandscapeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ControllersCubit controllersCubit =
        BlocProvider.of<ControllersCubit>(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    final videoName =
        VideoDetails(controllersCubit.videoCubit.videoPath).videoName;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            // PIPView.of(context)!.presentBelow(const NavBarScreen());
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
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Add Subtitle',
                          style: textTheme.headlineSmall,
                        ),
                        const Gap(10),
                        ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              allowedExtensions: ['srt'],
                              type: FileType.custom,
                            );
                            if (result != null) {
                              print(result.files.first.path);
                              controllersCubit.videoCubit.initSrtController(
                                choosedFile: result.files.first.path!,
                              );
                            }
                          },
                          child: const Text('Choose File'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          icon: const Icon(
            Icons.subtitles,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: controllersCubit.videoCubit.fullScreen,
          builder: (context, value, child) {
            return IconButton(
              onPressed: () {
                controllersCubit.videoCubit.fullScreen.value =
                    !controllersCubit.videoCubit.fullScreen.value;

                getIt<VideoviewCubit>().showControllers();
              },
              icon: controllersCubit.videoCubit.fullScreen.value
                  ? const Icon(
                      Icons.fullscreen_exit,
                    )
                  : const Icon(
                      Icons.fullscreen,
                    ),
            );
          },
        ),
      ],
    );
  }
}
