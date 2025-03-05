// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

WebViewEnvironment? webViewEnvironment;

// Future<void> handleBackgroundmessage(RemoteMessage message) async {
//   print('$message');
//   print('title : ${message.notification?.title}');
//   print('body : ${message.notification?.body}');
//   print('paylaod : ${message.data}');
// }

// Future<void> initPushNotifications() async {
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true, badge: true, sound: true);
//   FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   FirebaseMessaging.onBackgroundMessage(handleBackgroundmessage);
// }

// void handleMessage(RemoteMessage? message) {
//   print('>>>>>>>>>>');
//   if (message == null) return;
//   print('=============================================');
//   // navigatorKey.currentState
//   //     ?.pushNamed(NotificationScreen.route, arguments: message);
// }

// class FirebaseApi {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   Future initNotifications() async {
//     NotificationSettings settings =
//         await _firebaseMessaging.requestPermission();
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {}
//     // final fcmToken = await _firebaseMessaging.getToken();
//     // print("Token : $fcmToken");
//     await _firebaseMessaging.subscribeToTopic('web_to_apk');
//     initPushNotifications();
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await FirebaseApi().initNotifications();
  String webUrl = const String.fromEnvironment('WEB_URL',
      defaultValue: 'https://pixaware.co/');

  runApp(MyApp(webUrl: webUrl));
}

class MyApp extends StatefulWidget {
  final String webUrl;
  const MyApp({super.key, required this.webUrl});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  PullToRefreshController? pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();
  @override
  void initState() {
    super.initState();
    //
    // pullToRefreshController = kIsWeb ||
    //         ![TargetPlatform.iOS, TargetPlatform.android]
    //             .contains(defaultTargetPlatform)
    //     ? null
    //     : PullToRefreshController(
    //         settings: PullToRefreshSettings(
    //           color: Colors.blue,
    //         ),
    //         onRefresh: () async {
    //           if (defaultTargetPlatform == TargetPlatform.android) {
    //             webViewController?.reload();
    //           } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    //             webViewController?.loadUrl(
    //                 urlRequest:
    //                     URLRequest(url: await webViewController?.getUrl()));
    //           }
    //         },
    //       );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Official InAppWebView website")),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                InAppWebView(
                  key: webViewKey,
                  webViewEnvironment: webViewEnvironment,
                  initialUrlRequest: URLRequest(url: WebUri(widget.webUrl)),
                )
              ],
            )),
          ],
        )),
      ),
    );
  }
}
