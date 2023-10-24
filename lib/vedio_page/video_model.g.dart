// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideModel _$VideModelFromJson(Map<String, dynamic> json) => VideModel(
      title: json['title'] as String,
      url: json['url'] as String,
      count: json['count'] as int? ?? 0,
    );

Map<String, dynamic> _$VideModelToJson(VideModel instance) => <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'count': instance.count,
    };
