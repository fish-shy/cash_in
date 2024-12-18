import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<void> cameraPermission() async {
    await Permission.camera.onDeniedCallback(() {
      print('denied');
    }).onGrantedCallback(() {
      print('acc');
    }).onPermanentlyDeniedCallback(() {
      print('perm den');
    }).onRestrictedCallback(() {
      print('restricted');
    }).onLimitedCallback(() {
      print('limt');
    }).onProvisionalCallback(() {
    }).request();
  }
}
