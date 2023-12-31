import 'package:flutter/material.dart';
import 'package:mc/favorite_animation_icon.dart';

class FavoriteGesture extends StatefulWidget {
  final Widget child;

  static const double defaultSize = 100;
  final double size;

  const FavoriteGesture(
      {super.key, required this.child, this.size = defaultSize});

  @override
  State<FavoriteGesture> createState() => _FavoriteGestureState();
}

class _FavoriteGestureState extends State<FavoriteGesture> {
  Offset tmpOffSet = Offset.zero;
  final GlobalKey _gk = GlobalKey();
  List<Offset> offsets = [];

  //通过全局的key 找到  GestureDetector 对象 所在屏幕的位置 （如果用绝对定位的话，可能 后面的position 就不在 GestureDetector 元素里面）
  Offset _globalToRelationOffset(Offset globalOffset) {
    RenderBox? box = _gk.currentContext?.findRenderObject() as RenderBox?;
    return box!.globalToLocal(globalOffset);
  }

  @override
  Widget build(BuildContext context) {
    var iconStack = Stack(
      children: offsets
          .map((e) => FavoriteAnimationIcon(
                key: GlobalKey(),
                size: widget.size,
                animationComplete: () {
                  offsets.remove(e);
                },
                position: e,
              ))
          .toList(),
    );
    return GestureDetector(
      key: _gk,
      onDoubleTapDown: (details) {
        //在触发onDoubleTap（双击事件）时，一定会触发两次的onTapDown(手指按下)
        tmpOffSet = _globalToRelationOffset(details.globalPosition);
      },
      onDoubleTap: () {
        setState(() {
          offsets.add(tmpOffSet);
        });
      },
      child: Stack(
        children: [
          widget.child,
          Positioned(
              /**
               * 因为默认是按照点击的坐标点进行绘制的，我们需要的是 爱心点 在点击的坐标点的上下左右的偏移 ，
               * 看下面的例子
               * 如果不减去一半的宽度 和高度，那么结果是这样的
               *
               *
               *       mount
               *            ....
               *            ....
               *            ....
               *
               * 实际上我们需要的效果是
               *            .........
               *            ..mount..
               *            .........
               */

              child: iconStack),
        ],
      ),
    );
  }
}
