import 'dart:convert';
import 'dart:ffi';

import 'package:mc/vedio_page/server_data.dart';
import 'package:mc/vedio_page/video_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoController {
  VideModel? model;

  Future<void> init() async {
    if (null == model) {
      model = await fetchData();
    }
  }

  Future<VideModel> fetchData() async {
    var sp = await SharedPreferences.getInstance();
    if (sp.containsKey('vedio_list')) {
      return VideModel.fromJson(jsonDecode(sp.getString('vedio_list')!));
    }
    var json = ServerData.fetchData();
    sp.setString("vedio_list", json);
    return VideModel.fromJson(jsonDecode(json));
  }
}
