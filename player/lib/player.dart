import 'dart:io';

import 'package:fijkplayer/fijkplayer.dart';

class Player extends FijkPlayer {
  static String asset_url_suffix = "asset:///";

  bool cacheEnable = true;

  static String cachePath = '';
  String cache_key_prefix = 'ijkio:cache:ffio:';

  static void setCachePath(String cachePathTmp) {
    cachePath = cachePathTmp;
  }

  @override
  Future<void> setDataSource(String path,
      {bool autoPlay = false, bool showCover = false}) async {
    Uri uri = Uri.parse(path);
    var videoName = uri.pathSegments.last;
    if (cacheEnable) {
      var videoPath = this.getCacheFile(videoName, cachePath);
      if (File(videoPath).existsSync()) {
        path = videoPath;
      } else {
        path = '${cache_key_prefix}$path';
        setOption(FijkOption.formatCategory, 'cache_file_path', videoPath);
      }
    }
    super.setDataSource(path, autoPlay: autoPlay, showCover: showCover);
  }

  void setCommonDataSource(
    String url, {
    SourceType sourceType = SourceType.net,
    bool autoPlay = false,
    bool showCover = false,
  }) {
    if (sourceType == SourceType.local && !url.startsWith(asset_url_suffix)) {
      url = asset_url_suffix + url;
    }
    setDataSource(url, autoPlay: autoPlay, showCover: showCover);
  }

  getCacheFile(String videoName, String cachePath) {
    return "$cachePath/$videoName";
  }
}

enum SourceType { net, local }
