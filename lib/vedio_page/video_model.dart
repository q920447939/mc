import 'package:json_annotation/json_annotation.dart';
part 'video_model.g.dart';

@JsonSerializable()
class VideModel {
  String title;
  String url;
  int count;

  VideModel({required this.title, required this.url, this.count = 0});

  factory VideModel.fromJson(Map<String, dynamic> json) {
    return _$VideModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VideModelToJson(this);
  }
}
