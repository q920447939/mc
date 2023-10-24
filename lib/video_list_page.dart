import 'package:flutter/material.dart';
import 'package:player/player.dart';
import 'package:player/vedio_view.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return VideoViewState(new Player()
              ..setCommonDataSource(
                "assets/video/big_buck_bunny_720p_1mb.mp4",
                sourceType: SourceType.local,
                autoPlay: true,
              ));
          }),
    );
  }
}
