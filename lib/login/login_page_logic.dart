part of 'login_page.dart';

extension LoginPageLogic on _LoginPageState {
  Future<String> getDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      final userAgent = window.navigator.userAgent.toLowerCase();
      if (userAgent.contains('android')) {
        return 'Android Device';
      } else if (userAgent.contains('iphone') || userAgent.contains('ipad')) {
        return 'iOS Device';
      } else {
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        return webBrowserInfo.browserName.name.toString();
      }
    } else {
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

  bool areInitialAnswersEmpty() {
    if (Provider.of<PrefsData>(context, listen: false)
            .questions['carbrand']['answer']
            .toString()
            .isEmpty ||
        Provider.of<PrefsData>(context, listen: false)
            .questions['carvalue']['answer']
            .toString()
            .isEmpty ||
        Provider.of<PrefsData>(context, listen: false)
            .questions['yearofmake']['answer']
            .toString()
            .isEmpty) return true;
    return false;
  }
}
