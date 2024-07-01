import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/core/services/service_locator.dart';
import 'package:videoplayer/features/browse_videos/all_videos_cubit/all_videos_cubit.dart';
import 'package:videoplayer/features/browse_videos/views/browse_videos_view.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScreen[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: _navBarsItems(),
      ),
    );
  }
}

List<Widget> getScreen = [
  BlocProvider.value(
    value: getIt<AllVideosCubit>()..sortByDate(),
    child: const BrowseVideosView(),
  ),
  //w const SettingsScreen(),
];

List<BottomNavigationBarItem> _navBarsItems() {
  return [
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      label: ("Home"),
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.settings),
      label: ("Settings"),
    ),
  ];
}
