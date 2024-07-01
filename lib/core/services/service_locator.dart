import 'package:floating/floating.dart';
import 'package:get_it/get_it.dart';
import 'package:videoplayer/cubit/root_cubit.dart';
import 'package:videoplayer/features/video_player/cubits/videoview_cubit/videoview_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<Floating>(() => Floating());
  getIt.registerLazySingleton<VideoviewCubit>(() => VideoviewCubit());
  getIt.registerLazySingleton<RootCubit>(() => RootCubit());
}

Future<void> closeServiceLocator() async {
  getIt<Floating>().dispose();
}
