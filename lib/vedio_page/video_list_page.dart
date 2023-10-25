import 'package:flutter/material.dart';
import 'package:mc/vedio_page/video_controller.dart';
import 'package:player/player.dart';
import 'package:player/vedio_view.dart';

import '../MCRouter.dart';
import '../main.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  var url =
      "http://vd2.bdstatic.com/mda-pjmda4pa1evdzfb7/720p/h264/1697966790795865210/mda-pjmda4pa1evdzfb7.mp4?v_from_s=hkapp-haokan-hnb&auth_key=1697992517-0-0-faa80c647b78cd5adcf26d80e2a8edac&bcevod_channel=searchbox_feed&pd=1&cr=2&cd=0&pt=3&logid=2117830552&vid=1254042716516707199&klogid=2117830552&abtest=112751_4-112954_1-113704_1";

  late VideoController videoController;

  @override
  void initState() {
    videoController = VideoController();
    videoController.init();
    print("videoController.tile =>${videoController.model.title}");
    print("videoController.url =>${videoController.model.url}");
    print("videoController.playCount =>${videoController.model.count}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                await router.push(
                    name: MCRouter.playPage,
                    arguments: videoController.model.url);
              },
              child: AbsorbPointer(
                absorbing: true,
                child: VideoViewState(new Player()
                  ..setCommonDataSource(
                    videoController.model.url,
                    sourceType: SourceType.net,
                    autoPlay: false,
                  )),
              ),
            );
          }),
    );
  }
}
