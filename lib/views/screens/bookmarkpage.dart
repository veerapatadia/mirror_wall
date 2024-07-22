import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class bookmarkpage extends StatefulWidget {
  const bookmarkpage({super.key});

  @override
  State<bookmarkpage> createState() => _bookmarkpageState();
}

class _bookmarkpageState extends State<bookmarkpage> {
  @override
  Widget build(BuildContext context) {
    String data = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(data),
        ),
      ),
    );
  }
}
