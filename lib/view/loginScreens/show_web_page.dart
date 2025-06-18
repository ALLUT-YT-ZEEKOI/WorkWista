import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowWebPage extends StatefulWidget {
  final String url;
  const ShowWebPage({super.key, required this.url});

  @override
  State<ShowWebPage> createState() => _ShowWebPageState();
}

class _ShowWebPageState extends State<ShowWebPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(title: const Text("")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
