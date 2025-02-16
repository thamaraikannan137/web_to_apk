import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'api/firebase_api.dart';

WebViewEnvironment? webViewEnvironment;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String webUrl = const String.fromEnvironment('WEB_URL',
      defaultValue: 'https://flutter.dev');

  await FirebaseApi().initNotifications();
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

    pullToRefreshController = kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
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
