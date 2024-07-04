import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:videoplayer/core/consts/colors.dart';
import 'package:videoplayer/core/database/hive.dart';
import 'package:videoplayer/core/services/service_locator.dart';
import 'package:videoplayer/core/theme/my_theme.dart';
import 'package:videoplayer/cubit/root_cubit.dart';
import 'package:videoplayer/root_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPrimaryColor();
  setupServiceLocator();
  await MyHive.initHive();

  runApp(const MyApp());
  await MyHive.saveToSrtBox();
  //  await MobileAds.instance.initialize();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Play',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: BlocProvider(
        create: (context) => RootCubit()..checkAndRequestStoragePermission(),
        child: const RootView(),
      ),
    );
  }
}
