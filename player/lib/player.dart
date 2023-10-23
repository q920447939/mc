import 'package:fijkplayer/fijkplayer.dart';

class Player extends FijkPlayer {
  static String asset_url_suffix = "assets:///";

  void setCommonDataSource(
    String url, {
    SourceType sourceType = SourceType.net,
    bool autoPlay = false,
    bool showCover = false,
  }) {
    if (sourceType == SourceType.local && !url.startsWith(asset_url_suffix)) {
      url = asset_url_suffix + url;
    }
    super.setDataSource(url, autoPlay: autoPlay, showCover: showCover);
  }
}

enum SourceType { net, local }
