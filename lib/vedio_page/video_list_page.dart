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
  late VideoController videoController;

  @override
  void initState() {
    super.initState();
    videoController = VideoController();
    videoController.init().then((value) {
      setState(() {});
    });
    /* print("videoController.tile =>${videoController.model?.title}");
    print("videoController.url =>${videoController.model?.url}");
    print("videoController.playCount =>${videoController.model?.count}");*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: videoController.dataList?.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                await router.push(
                    name: MCRouter.playPage,
                    arguments: videoController.dataList![index].url);
              },
              child: videoController.dataList == null
                  ? Container()
                  : AbsorbPointer(
                      absorbing: true,
                      child: VideoViewState(Player()
                        ..setCommonDataSource(
                          videoController.dataList![index].url,
                          sourceType: SourceType.net,
                          autoPlay: true,
                        )),
                    ),
            );
          }),
    );
  }
}
