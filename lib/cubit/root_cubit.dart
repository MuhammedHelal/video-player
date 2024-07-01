import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit() : super(RootInitial());

  final DeviceInfoPlugin androidInfo = DeviceInfoPlugin();
  late int androidVersion;

  Future<void> checkAndRequestStoragePermission() async {
    try {
      await androidInfo.androidInfo.then((value) {
        androidVersion = int.parse(value.version.release);
      });
    } catch (e) {
      androidVersion = 0;
      throw ("Unsupported Android Version");
    }

    if (androidVersion >= 13) {
      bool result = await Permission.manageExternalStorage.isGranted;
      await handlePermissionStates(result);
    } else {
      bool result = await Permission.storage.isGranted;
      await handlePermissionStates(result);
    }
  }

  Future<bool> checkStoragePermission() async {
    try {
      await androidInfo.androidInfo.then((value) {
        androidVersion = int.parse(value.version.release);
      });
    } catch (e) {
      androidVersion = 0;
      throw ("Unsupported Android Version");
    }
    if (androidVersion >= 13) {
      bool result = await Permission.manageExternalStorage.isGranted;
      if (result) {
        return true;
      } else {
        return false;
      }
    } else {
      bool result = await Permission.storage.isGranted;
      if (result) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<PermissionStatus> requestStoragePermission() async {
    PermissionStatus permissionStatus;
    try {
      await androidInfo.androidInfo.then((value) {
        androidVersion = int.parse(value.version.release);
      });
    } catch (e) {
      androidVersion = 0;
      throw ("Unsupported Android Version");
    }
    if (androidVersion >= 13) {
      permissionStatus = await Permission.manageExternalStorage.request();
    } else {
      permissionStatus = await Permission.storage.request();
    }

    return permissionStatus;
  }

  Future<void> handlePermissionStates(bool result) async {
    if (result) {
      emit(PermissionGranted());
    } else {
      PermissionStatus permission = await requestStoragePermission();
      if (permission.isGranted) {
        emit(PermissionGranted());
      } else if (permission.isPermanentlyDenied) {
        emit(PermissionPermenantDenied());
      } else {
        emit(PermissionDenied());
      }
    }
  }
}
