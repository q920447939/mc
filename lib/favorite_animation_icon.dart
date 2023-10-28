import 'package:flutter/material.dart';

class FavoriteAnimationIcon extends StatefulWidget {
  static const double _defaultSize = 100;
  @override
  final Key key;
  final double size;

  final Offset position;

  Function? animationComplete;

  FavoriteAnimationIcon(
      {required this.key,
      this.size = _defaultSize,
      this.animationComplete,
      required this.position})
      : super(key: key);

  @override
  State<FavoriteAnimationIcon> createState() => _FavoriteAnimationIconState();
}

class _FavoriteAnimationIconState extends State<FavoriteAnimationIcon>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  static const int _duration = 600;

  /**
   *
   * 透明度变化，  有三个阶段
   * 1阶段（appearValue） 启动动画
   * 2.透明度持续
   * 3.结束透明度
   *
   */
  static const double appearValue = 0.1;
  static const double dismissValue = 0.1;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: _duration),
      vsync: this,
    );
    animationController.addListener(() {
      setState(() {});
    });
    startAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var child = Icon(
      Icons.favorite,
      color: Colors.red,
      size: widget.size,
    );
    return Positioned(
        top: widget.position.dy - widget.size / 2,
        left: widget.position.dx - widget.size / 2,
        child: Opacity(
          opacity: opacity,
          child: child,
        ));
  }

  double get value {
    return this.animationController.value;
  }

  double get opacity {
    if (value < appearValue) {
      // 处于渐进阶段，播放透明度动画
      return value / appearValue;
    }
    if (value < dismissValue) {
      //处于展示阶段，不需要动画
      return 1;
    }
    //结束阶段
    return (1 - value) / (1 - dismissValue);
  }

  Future startAnimation() async {
    await animationController.forward();
    widget.animationComplete?.call();
  }
}
