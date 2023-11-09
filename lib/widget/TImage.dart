import 'dart:io';

import 'package:flutter/material.dart';

class TImage extends StatefulWidget {
  final String url;
  double? width;
  double? height;
  final fit;

  TImage(this.url,
      {super.key, this.fit = BoxFit.cover, this.width, this.height});

  @override
  State<TImage> createState() => _TImageState();
}

class _TImageState extends State<TImage> {
  @override
  Widget build(BuildContext context) {
    var url = widget.url;
    var width = widget.width;
    var height = widget.height;
    var fit = widget.fit;
    if (url.contains("asset")) {
      return Image.asset(
        url,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return Image.file(
        File(url),
        width: width,
        height: height,
        fit: fit,
      );
    }

    // return const Placeholder();
  }
}
