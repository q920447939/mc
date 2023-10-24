import 'dart:convert';

import 'package:mc/vedio_page/video_model.dart';

class VideoController {
  static const String data = """
  {
    "title": "新闻",
    "url": "http://vd2.bdstatic.com/mda-pjmda4pa1evdzfb7/720p/h264/1697966790795865210/mda-pjmda4pa1evdzfb7.mp4?v_from_s=hkapp-haokan-hnb&auth_key=1697992517-0-0-faa80c647b78cd5adcf26d80e2a8edac&bcevod_channel=searchbox_feed&pd=1&cr=2&cd=0&pt=3&logid=2117830552&vid=1254042716516707199&klogid=2117830552&abtest=112751_4-112954_1-113704_1",
    "count": 88
}
  """;

  late VideModel model;

  void init() {
    model = fetchData();
  }

  VideModel fetchData() {
    return VideModel.fromJson(jsonDecode(data));
  }
}
