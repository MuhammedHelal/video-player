import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:videoplayer/core/database/hive.dart';
import 'package:videoplayer/features/browse_videos/widgets/video_item_list_tile.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> searchResult = [];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _textEditingController,
                onChanged: (value) async {
                  int previousLength = searchResult.length;
                  searchResult =
                      await MyHive.searchInBox(_textEditingController.text);
                  if (previousLength != searchResult.length) {
                    setState(() {});
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Search videos',
                  labelStyle: textTheme.labelLarge,
                  suffixIcon: const Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  final VideoDetails videoDetails =
                      VideoDetails(searchResult[index]);
                  return VideoListTile(videoDetails: videoDetails);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
