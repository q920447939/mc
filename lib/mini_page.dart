import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mc/gen/assets.gen.dart';
import 'package:mc/photo_picker.dart';
import 'package:mc/widget/TImage.dart';

import 'image_from_gallery_ex.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  static const image_height = 138.5;

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showActionSheet(BuildContext context) {
    print("22222");
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('从相册选择照片或拍摄一张照片'),
        //message: const Text('Message'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// default behavior, turns the action's text to bold text.
            //isDefaultAction: true,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ImageFromGalleryEx(ImageSourceType.gallery)));
            },
            child: const Text('从相册选择'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ImageFromGalleryEx(ImageSourceType.camera)));
            },
            child: const Text('拍一张照片'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              /* router.push(
                  name: MCRouter.photoPickerPage,
                  arguments: ImageSourceType.gallery);*/
              onPressed:
              _showActionSheet(context);
            },
            child: Container(
              width: double.infinity,
              height: image_height,
              child: TImage(
                url: Assets.images.defaultBackground.path,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
