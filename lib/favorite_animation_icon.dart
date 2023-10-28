import 'dart:math';

import 'package:flutter/material.dart';

/**
  图标动画
  图标先在屏幕上显示,然后在屏幕上消失（划为 3个状态 。
      状态1  是启动状态  该状态 图标会逐渐显现
      状态2  是显示状态  该状态 图标会一直显示 （没有透明度的概念了，）
      状态3  是消失状态  该状态 图标会逐渐消失
    ）  当状态3 完成后，会进行回调
 */
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

  static const int _duration = 800;

  /**
   *
   * 透明度变化，  有三个阶段
   * 1阶段（appearValue） 启动动画
   * 2.透明度持续
   * 3.结束透明度
   *
   */
  static const double appearValue = 0.1;
  static const double dismissValue = 0.7;

  /**
      (2 * Random().nextDouble() - 1);
      Random().nextDouble() 的取值范围是 [0, 1]
      2 * Random().nextDouble()  的取值范围是 [0, 2]， 再 -1 的范围 是 [-1, 1]

      圆周率π的值约为3.14159
      π/10表示将圆周率除以10,计算结果约为:

      π/10 = 3.14159/10 约等于 0.314159

      这个结果约等于0.314弧度。

      1弧度约等于57.3度。

      所以π/10弧度约等于:

      0.314 * 57.3 ≈ 18 度

      也就是π/10弧度值约为18度。

      所以这里的范围区间是 [-18, 18]
   */
  double angle = pi / 10 * (2 * Random().nextDouble() - 1);

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
    var content = Icon(
      Icons.favorite,
      color: Colors.red,
      size: widget.size,
    );
    //渐变
    var shaderMask = ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
                colors: [Color(0xFFEE6E6E), Color(0xFFF03F03)],
                center: Alignment.topLeft.add(Alignment(0.66, 0.66)))
            .createShader(bounds);
      },
      // 尺寸放大缩小
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.bottomCenter,
        child: content,
      ),
    );

    return Positioned(
        top: widget.position.dy - widget.size / 2,
        left: widget.position.dx - widget.size / 2,
        //透明度
        child: Opacity(
          opacity: opacity,
          //角度旋转
          child: Transform.rotate(
            angle: angle,
            child: shaderMask,
          ),
        ));
  }

  double get value {
    return this.animationController.value;
  }

  double get opacity {
    if (value < appearValue) {
      // 处于渐进阶段，播放透明度动画
      /// value 占比越来越高 ， 会越来越不透明（会越来越清晰）
      return value / appearValue;
    }
    if (value < dismissValue) {
      //处于展示阶段，需要动画
      /// 一直清晰  此状态持续时间最长
      return 1;
    }
    //结束阶段   value 越来越趋近与0  0代表透明
    /// 比如 当value = 0.8 时 ，那么分子为 1-0.8=0.2 分母为 0.3 结果为 2/3
    /// 比如 当value = 0.9 时 ，那么分子为 1-0.9=0.1 分母为 0.3 结果为 1/3
    /// 比如 当value = 1 时 ，那么分子为 1-1=0 结果为0
    return (1 - value) / (1 - dismissValue);
  }

  double get scale {
    if (value < appearValue) {
      return value;
    }
    if (value < dismissValue) {
      return 1;
    }
    //第三阶段  尺寸放大
    //  (1 - dismissValue) 代表是最后一段的区间值
    // (value - dismissValue) 代表的是 value 走过最后一段的区间值 该值随着value 变大， 而 (value - dismissValue) 结果变大
    //抛开前面的 1 ，即 代表   当前value走过的路程 在最后一段 所处的比例 ,如下面的例子所示， 当value越来越大时 ，那么结果会越来越大（ 那么会 图标的尺寸会越来越大）
    // 当 value = 0.8的时候   (value - dismissValue) = 0.1  (1 - dismissValue) = 0.3   比值为 0.1 / 0.3 = 1 / 3
    // 当 value = 0.9的时候   (value - dismissValue) = 0.2  (1 - dismissValue) = 0.3   比值为 0.2 / 0.3 = 2 / 3
    return 1 + ((value - dismissValue) / (1 - dismissValue));
  }

  Future startAnimation() async {
    await animationController.forward();
    widget.animationComplete?.call();
  }
}
