import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:player/player.dart';

class VideoViewState extends StatefulWidget {
  Player player;

  VideoViewState(this.player);

  @override
  State<VideoViewState> createState() => _VideoViewStateState();
}

class _VideoViewStateState extends State<VideoViewState> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FijkView(
          player: widget.player,
        ),
        Align(
          child: Image.asset("assets/images/player.png"),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
