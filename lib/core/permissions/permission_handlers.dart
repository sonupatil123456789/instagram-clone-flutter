import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandling {
  static Future<void> requestAllServicesPermissions() async {
    try {
      // Request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
        Permission.camera,
        Permission.photos,
      ].request();
    } catch (e) {
      ListnersUtils.showToastMessage(
        "Error During Requesting Permission",
        errorColor,
      );
    }
  }

  static Future<bool> checkPermission() async {
    CoustomLog.coustomLogData(
        "checkPermission ", "checkPermission running ---------------");
    try {
      var cameraStatus = await Permission.camera.status;
      var photosStatus = await Permission.photos.status;
      var storageStatus = await Permission.storage.status;
      var locationStatus = await Permission.location.status;

      if (storageStatus.isDenied ||
          photosStatus.isDenied ||
          cameraStatus.isDenied ||
          locationStatus.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
          Permission.location,
          Permission.camera,
          Permission.photos,
        ].request();

        // Check statuses after requesting again.
        if (statuses.values.any((status) => status.isDenied)) {
          return false;
        }
        return true;
      }

      if (storageStatus.isPermanentlyDenied ||
          photosStatus.isPermanentlyDenied ||
          cameraStatus.isPermanentlyDenied ||
          locationStatus.isPermanentlyDenied) {
      await openAppSettings();
        return false;
      }

      if (storageStatus.isGranted &&
          photosStatus.isGranted &&
          cameraStatus.isGranted &&
          locationStatus.isGranted) {
        return true;
        
      } else {
        return storageStatus.isGranted &&
            photosStatus.isGranted &&
            cameraStatus.isGranted &&
            locationStatus.isGranted;
      }
    } catch (e) {
      ListnersUtils.showToastMessage(
        "Error During Requesting Permission",
        errorColor,
      );
      return false;
    }
  }
}
