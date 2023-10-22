import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  static const String url =
      "https://vd2.bdstatic.com/mda-pjmda4pa1evdzfb7/720p/h264/1697966790795865210/mda-pjmda4pa1evdzfb7.mp4?v_from_s=hkapp-haokan-hnb&auth_key=1697992517-0-0-faa80c647b78cd5adcf26d80e2a8edac&bcevod_channel=searchbox_feed&pd=1&cr=2&cd=0&pt=3&logid=2117830552&vid=1254042716516707199&klogid=2117830552&abtest=112751_4-112954_1-113704_1";
  @override
  Widget build(BuildContext context) {
    print(url);
    var fijkPlayer = FijkPlayer()..setDataSource(url, autoPlay: true);
    var view = FijkView(player: fijkPlayer);
    return Scaffold(
      body: view,
    );
  }
}
