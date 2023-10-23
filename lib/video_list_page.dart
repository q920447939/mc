import 'package:flutter/cupertino.dart';
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
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return VideoViewState(new Player()
              ..setCommonDataSource(
                "/assets/video/SampleVideo_1280x720_5mb.flv",
                sourceType: SourceType.local,
                autoPlay: true,
              ));
          }),
    );
  }
}
