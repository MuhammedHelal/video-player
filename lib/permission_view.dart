import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:videoplayer/core/consts/colors.dart';
import 'package:videoplayer/core/services/service_locator.dart';
import 'package:videoplayer/cubit/root_cubit.dart';
import 'package:videoplayer/features/browse_videos/all_videos_cubit/all_videos_cubit.dart';
import 'package:videoplayer/features/browse_videos/views/browse_videos_view.dart';

class PermissionView extends StatefulWidget {
  const PermissionView({
    super.key,
  });

  @override
  State<PermissionView> createState() => _PermissionViewState();
}

class _PermissionViewState extends State<PermissionView>
    with WidgetsBindingObserver {
  late RootCubit rootCubit = getIt<RootCubit>();
  late TextTheme textTheme;
  late NavigatorState navigator;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    navigator = Navigator.of(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermissionStatus();
    }
  }

  Future<void> _checkPermissionStatus() async {
    bool granted = await rootCubit.checkStoragePermission();
    if (granted) {
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AllVideosCubit()..saveToVideosBox(),
            child: const BrowseVideosView(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(100),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: primaryColor,
                  ),
                  const Gap(5),
                  Text(
                    'Storage Permission required!',
                    style: textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
            const Gap(20),
            Text(
              textAlign: TextAlign.center,
              'Please, accept storage permission so the app can work properly and get your videos ',
              style: textTheme.bodyLarge,
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: () async {
                final permission = await rootCubit.requestStoragePermission();
                if (permission.isGranted) {
                  navigator.pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                            AllVideosCubit()..saveToVideosBox(),
                        child: const BrowseVideosView(),
                      ),
                    ),
                  );
                } else if (permission.isPermanentlyDenied) {
                  await openAppSettings();
                }
              },
              child: const Text('Storage permission'),
            ),
          ],
        ),
      )),
    );
  }
}
