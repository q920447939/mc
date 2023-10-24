import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/player.dart';
import 'package:player/vedio_view.dart';

class PlayerPage extends StatefulWidget {
  final String url;

  const PlayerPage({super.key, required this.url});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late Player player;

  @override
  void initState() {
    super.initState();
    player = Player();
    player.setCommonDataSource(widget.url,
        sourceType: SourceType.local, autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return VideoViewState(player);
  }
}
