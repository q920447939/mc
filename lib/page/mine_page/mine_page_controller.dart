import 'package:get/get.dart';
import 'package:mc/gen/assets.gen.dart';

class MinePageController extends GetxController {
  //头像
  var _avatarPath = Assets.images.defaultAvator.path.obs;
  //背景
  var _backgroundPath = Assets.images.defaultBackground.path.obs;
  var _triangle_down = Assets.images.triangleDown.path.obs;

  set avatarPath(value) => _avatarPath.value = value;

  get avatarPath => _avatarPath.value;

  get backgroundPath => _backgroundPath.value;

  set backgroundPath(value) => _backgroundPath.value = value;
  String get likeCount => "23W";
  String get focusCount => "84446";
  String get followCount => "2256";

  var _name = "刘备".obs;
  var _uid = "9999".obs;
  var _signature = "".obs;

  String get name => _name.value;
  String get uidDesc => "用户id： ${_uid.value}";
  //签名
  String get signature =>
      _signature.value == "" ? "点击添加介绍,让大家认识你..." : _signature.value;

  get triangleDownIcon => _triangle_down.value;
}
