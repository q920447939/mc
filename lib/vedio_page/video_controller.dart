import 'dart:convert';
import 'dart:ffi';

import 'package:mc/vedio_page/server_data.dart';
import 'package:mc/vedio_page/video_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoController {
  List<VideModel>? dataList;

  Future<void> init() async {
    if (null == dataList) {
      dataList = await fetchData();
    }
  }

  Future<List<VideModel>> fetchData() async {
/*    var sp = await SharedPreferences.getInstance();
    if (sp.containsKey('vedio_list')) {
      return VideModel.fromJson(jsonDecode(sp.getString('vedio_list')!));
    }*/
    // 去掉缓存了
    var list = jsonDecode(ServerData.fetchData()) as List<dynamic>;
    return list.map((json) => VideModel.fromJson(json)).toList();
  }
}
