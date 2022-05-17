import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsView extends StatefulWidget {

  final String viewUrl;
  const NewsView(this.viewUrl);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
   @override
   void initState() {
     super.initState();
     if (Platform.isAndroid) WebView.platform = AndroidWebView();
   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
         initialUrl: widget.viewUrl,
       ),
    );
  }
}