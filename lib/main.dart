import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  String webUrl = const String.fromEnvironment('WEB_URL',
      defaultValue: 'https://flutter.dev');
  runApp(MyApp(webUrl: webUrl));
}

class MyApp extends StatelessWidget {
  final String webUrl;
  const MyApp({super.key, required this.webUrl});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Web to apk')),
        body: Center(child: Text('Website : $webUrl')),
      ),
    );
  }
}
