import 'dart:io';

import 'package:flutter/material.dart';

class TImage extends StatefulWidget {
  final String url;
  double? width;
  double? height;
  final fit;

  double? radius;
  final shape;

  TImage(this.url,
      {super.key,
      this.fit = BoxFit.cover,
      this.width,
      this.height,
      this.shape = Shape.normal,
      this.radius});

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
    switch (widget.shape) {
      case Shape.normal:
        return _getImage(url, width, height, fit);
      case Shape.circle:
        print("circle==${url}");

        ImageProvider imageProvider;

        if (url.contains('asset')) {
          imageProvider = AssetImage(url);
        } else {
          imageProvider = FileImage(File(url));
        }
        var radius2 = widget.radius;
        //设置一个圆形的图片
        return Container(
          width: radius2! * 2,
          height: radius2 * 2,
          decoration: BoxDecoration(
              // Radius.circular(50) 生成圆形的比例 ，越大越像圆
              borderRadius: BorderRadius.all(Radius.circular(40)),
              //给圆设置一个边界 ，这样会在外层套上一个白色的边框
              border: Border.all(
                color: Color(0xfffefefe),
                width: 3,
              ),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              )),
        );
    }

    return Container();
    // return const Placeholder();
  }

  Image _getImage(String url, double? width, double? height, fit) {
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
  }
}

enum Shape { normal, circle }
