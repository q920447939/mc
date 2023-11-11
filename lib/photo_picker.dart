import 'package:flutter/material.dart';
import 'package:mc/main.dart';
import 'package:mc/widget/t_image.dart';
import 'package:image_picker/image_picker.dart';

enum ImageSourceType { gallery, camera }

class PhotoPicker extends StatelessWidget {
  final String url;
  double? width;
  double? height;

  PhotoPicker(this.url, {this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            router.popRoute();
          },
          child: TImage(url, width: width, height: height),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(bottom: 85),
            child: GestureDetector(
              onTap: () async {
                var xFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                var path = xFile?.path;
                if (path != null) {
                  router.popRoute(params: path);
                }
              },
              child: Container(
                alignment: Alignment.center,
                color: Color(0xff262626),
                width: 196,
                height: 30,
                child: Text(
                  '更换背景',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
