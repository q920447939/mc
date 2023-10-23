import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: GestureDetector(
        onTap: _onTapVideo,
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: true,
              child: FijkView(
                player: widget.player,
              ),
            ),
            if (widget.player.state == FijkState.paused)
              Align(
                child: Icon(Icons.play_arrow, size: 70),
                alignment: Alignment.center,
              ),
          ],
        ),
      ),
    );
  }

  _onTapVideo() {
    if (widget.player.state == FijkState.paused) {
      widget.player.start();
    } else {
      widget.player.pause();
    }
    setState(() {});
  }
}
