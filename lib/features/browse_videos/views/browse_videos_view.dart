
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/core/admob/ads_widgets/banner_ad_widget.dart';
import 'package:videoplayer/core/database/hive.dart';
import 'package:videoplayer/features/browse_videos/all_videos_cubit/all_videos_cubit.dart';
import 'package:videoplayer/features/browse_videos/all_videos_cubit/all_videos_state.dart';
import 'package:videoplayer/features/browse_videos/widgets/browse_videos_appbar.dart';
import 'package:videoplayer/features/browse_videos/widgets/video_widget.dart';

class BrowseVideosView extends StatelessWidget {
  const BrowseVideosView({super.key});

  @override
  Widget build(BuildContext context) {
    final AllVideosCubit allVideosCubit =
        BlocProvider.of<AllVideosCubit>(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await allVideosCubit.saveToVideosBox();
        },
        child: BlocConsumer<AllVideosCubit, AllVideosState>(
          listener: (context, state) {
            if (state is UpdateDatabaseSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(
                    child: Text('Updated Videos List'),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is UpdateDatabaseSuccess) {
              return Padding(
                padding: const EdgeInsets.all(0),
                child: CustomScrollView(
                  slivers: [
                    const BrowseVideosSliverAppBar(),
                    SliverList.builder(
                      key: GlobalKey(),
                      itemCount: MyHive.videosBox.length,
                      itemBuilder: (context, index) {
                        int reversedIndex = MyHive.videosBox.length - 1 - index;
                        return VideoItem(index: reversedIndex);
                      },
                    ),

                    /*   SliverToBoxAdapter(
                    child: BlocConsumer<AllVideosCubit, AllVideosState>(
                      listener: (context, state) {
                        if (state is UpdateDatabaseSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(
                                child: Text('Updated Videos List'),
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is UpdateDatabaseSuccess) {
                          return SliverList.builder(
                            itemCount: MyHive.videosBox.length,
                            itemBuilder: (context, index) {
                              int reversedIndex =
                                  MyHive.videosBox.length - 1 - index;
                              return VideoItem(index: reversedIndex);
                            },
                            /*   child: Padding(
                                  padding: EdgeInsets.zero,
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: MyHive.videosBox.length,
                                    itemBuilder: (context, index) {
                                      int reversedIndex =
                                          MyHive.videosBox.length - 1 - index;
                                      return VideoItem(index: reversedIndex);
                                    },
                                  ),
                                ),*/
                          );
                          return Padding(
                            padding: EdgeInsets.zero,
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                for (int index = MyHive.videosBox.length - 1;
                                    index >= 0;
                                    index--)
                                  VideoItem(index: index)
                              ],
                            ),
                          );
                        } else {
                          return SliverList.builder(
                            key: GlobalKey(),
                            itemCount: MyHive.videosBox.length,
                            itemBuilder: (context, index) {
                              int reversedIndex =
                                  MyHive.videosBox.length - 1 - index;
                              return VideoItem(index: reversedIndex);
                            },
                          );
                          return ListView.builder(
                            itemCount: MyHive.videosBox.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              int reversedIndex =
                                  MyHive.videosBox.length - 1 - index;
                              return VideoItem(index: reversedIndex);
                            },
                          );
                          return ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              for (int index = MyHive.videosBox.length - 1;
                                  index >= 0;
                                  index--)
                                VideoItem(index: index)
                            ],
                          );
                        }
                      },
                    ),
                  ),*/
                  ],
                ),
              );
            } else {
              return CustomScrollView(
                slivers: [
                  const BrowseVideosSliverAppBar(),
                  SliverList.builder(
                    key: GlobalKey(),
                    itemCount: MyHive.videosBox.length,
                    itemBuilder: (context, index) {
                      int reversedIndex = MyHive.videosBox.length - 1 - index;
                      if (index % 7 == 2) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 100,
                              width: double.infinity,
                              child: BannerAdWidget(),
                            ),
                            VideoItem(index: reversedIndex),
                          ],
                        );
                      } else {
                        return VideoItem(index: reversedIndex);
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
