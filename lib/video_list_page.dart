import 'package:flutter/material.dart';
import 'package:player/player.dart';
import 'package:player/vedio_view.dart';

import 'MCRouter.dart';
import 'main.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  @override
  Widget build(BuildContext context) {
    var url = "assets/video/big_buck_bunny_720p_1mb.mp4";
    return Scaffold(
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                await router.push(name: MCRouter.playPage, arguments: url);
              },
              child: AbsorbPointer(
                absorbing: true,
                child: VideoViewState(new Player()
                  ..setCommonDataSource(
                    url,
                    sourceType: SourceType.local,
                    autoPlay: false,
                  )),
              ),
            );
          }),
    );
  }
}
