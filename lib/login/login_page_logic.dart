part of 'login_page.dart';

extension LoginPageLogic on _LoginPageState {
  Future<String> getDevice() async {
    if (kIsWeb) {
      final userAgent = window.navigator.userAgent.toLowerCase();
      if (userAgent.contains('android')) {
        return 'Android Device';
      } else if (userAgent.contains('iphone') || userAgent.contains('ipad')) {
        return 'iOS Device';
      } else {
        return 'Unknown Web Device';
      }
    } else {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (io.Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.model ?? 'Unknown Android Model';
      } else if (io.Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.model ?? 'Unknown iOS Model';
      } else {
        return 'Unknown Device';
      }
    }
  }
}