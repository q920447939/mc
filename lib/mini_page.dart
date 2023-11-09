import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mc/gen/assets.gen.dart';
import 'package:mc/photo_picker.dart';
import 'package:mc/widget/TImage.dart';

import 'MCRouter.dart';
import 'image_from_gallery_ex.dart';
import 'main.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  static const image_height = 138.5;
  //头像
  String avatarPath = Assets.images.defaultBackground.path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              var path = await router.push(
                  name: MCRouter.photoPickerPage, arguments: avatarPath);
              print("mounted is ${mounted}");
              if (path != null && path is String && mounted) {
                print("path is ${path}");
                avatarPath = path.toString();
                setState(() {});
              }
            },
            child: Container(
              width: double.infinity,
              height: image_height,
              child: TImage(
                avatarPath,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
