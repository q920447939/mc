import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc/widget/t_image.dart';
import 'package:mc/widget/text_count.dart';

import '../../MCRouter.dart';
import '../../main.dart';
import 'mine_page_controller.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  static const image_height = 138.5;
  final _controller = Get.put(MinePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              var path = await router.push(
                  name: MCRouter.photoPickerPage,
                  arguments: _controller.backgroundPath);
              print(
                  "mounted is ${mounted}"); //TODO 这里的mouted 是false 实际上应该为true才对.. 不过用了Getx框架后解决了这个问题， 暂时不知道怎么解决的！
              if (path != null && path is String) {
                print("path is ${path}");
                _controller.backgroundPath = path;
              }
            },
            child: Container(
              width: double.infinity,
              height: image_height,
              child: TImage(
                _controller.backgroundPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          //资料页
          Padding(
            padding: EdgeInsets.only(top: image_height - 4),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xfffefefe),
                  //设置卡面上面的圆角
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              child: _buildCard(),
            ),
          ),

          //头像
          Padding(
            padding: EdgeInsets.only(left: 19, top: 120),
            child: GestureDetector(
              onTap: () async {
                var path = await router.push(
                    name: MCRouter.photoPickerPage,
                    arguments: _controller.avatarPath);
                print(
                    "mounted is ${mounted}"); //TODO 这里的mouted 是false 实际上应该为true才对.. 不过用了Getx框架后解决了这个问题， 暂时不知道怎么解决的！
                if (path != null && path is String) {
                  print("path is ${path}");
                  _controller.avatarPath = path;
                }
              },
              child: TImage(
                _controller.avatarPath,
                shape: Shape.circle,
                radius: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, //从左往右
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 100,
              ),
              Expanded(
                  child: TextCount(
                text: '获赞',
                num: _controller.likeCount,
              )),
              Container(
                width: 1,
                color: Color(0xffe3e2e2),
                height: 33,
              ), //一条竖线，宽度为1
              Expanded(
                  child: TextCount(
                text: '关注',
                num: _controller.focusCount,
              )),
              Container(
                width: 1,
                color: Color(0xffe3e2e2),
                height: 33,
              ), //一条
              Expanded(
                  child: TextCount(
                text: '粉丝',
                num: _controller.followCount,
              )),
              Container(
                width: 1,
                color: Color(0xffe3e2e2),
                height: 33,
              ), //一条
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 19, top: 25),
            child: Obx(() => Text(
                  _controller.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                )),
          ),
          Padding(
              padding: EdgeInsets.only(left: 19, top: 5),
              child: Obx(
                () => Text(
                  _controller.uidDesc,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      decoration: TextDecoration.none),
                ),
              )),
          //横线分隔线
          Padding(
            padding: EdgeInsets.only(left: 19, top: 10, right: 19),
            child: Container(
              color: Color(0xffe3e2e2),
              height: 1,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 19, top: 10),
            child: GestureDetector(
              onTap: () {
                //增加提示  开发中...
              },
              child: Row(
                children: [
                  Text(_controller.signature,
                      style: TextStyle(fontSize: 12, color: Color(0xff747379))),
                  Icon(
                    Icons.edit,
                    color: Color(0xff747379),
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
          //关注
          Padding(
            padding: EdgeInsets.only(left: 19, right: 19, top: 10),
            child: Container(
              height: 36,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xfffe2d54),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(
                "+ 关注",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        ]);
  }
}
