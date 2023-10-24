import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mc/vedio_page/video_controller.dart';
import 'package:player/player.dart';
import 'package:player/vedio_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class PlayerPage extends StatefulWidget {
  final String url;

  const PlayerPage({super.key, required this.url});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late VideoController videoController;

  @override
  void initState() {
    super.initState();
    videoController = VideoController();
    videoController.init();
    print("videoController.tile =>${videoController.model.title}");
    print("videoController.url =>${videoController.model.url}");
    print("videoController.playCount =>${videoController.model.count}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        //长按出现对话框
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('提示'),
                content: Text('确定要下载本视频吗?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('取消')),
                  TextButton(
                      onPressed: () {
                        _saveVideo(widget.url);
                        Navigator.pop(context);
                      },
                      child: Text('确定'))
                ],
              );
            });
      },
      child: VideoViewState(Player()
        ..setCommonDataSource(widget.url,
            sourceType: SourceType.net, autoPlay: true)),
    );
  }

  void _saveVideo(String url) async {
    Uri uri = Uri.parse(url);
    String fileName = uri.pathSegments.last;
    //保存视频
    var path = await getApplicationSupportDirectory();
    print('获取到的下载路径:${path}');
    final dio = Dio();
    dio.download(url, '${path.path}/${fileName}',
        onReceiveProgress: (int count, int total) {
      int process = (count / total * 100).toInt();
      print('下载进度:' + process.toString());
    });
  }
}
