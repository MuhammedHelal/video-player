import 'package:flutter/material.dart';
import 'package:videoplayer/features/browse_videos/views/search_view.dart';

class BrowseVideosSliverAppBar extends StatelessWidget {
  const BrowseVideosSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 70.0,
      floating: true,
      pinned: false,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Videos',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        titlePadding: const EdgeInsets.only(left: 25, bottom: 5),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const SearchView();
                },
              ),
            );
          },
          icon: const Icon(Icons.search),
        ),
        /*  PopupMenuButton(
          icon: const Icon(Icons.more_horiz),
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'date',
                child: Text('Date Added'),
              ),
              const PopupMenuItem(
                value: 'size',
                child: Text('Size'),
              ),
              const PopupMenuItem(
                value: 'duration',
                child: Text('Duration'),
              ),
            ];
          },
          onSelected: (value) async {
            if (value == 'size') {
              // await videosCubit.sortBySize();
            } else if (value == 'duration') {
              // await videosCubit.sortByDuration();
            } else {
              //    await videosCubit.sortByDate();
            }
          },
        )*/
      ],
      //   title: const Text('Browse Videos'),
    );
  }
}
