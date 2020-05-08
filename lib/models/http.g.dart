// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Http _$HttpFromJson(Map<String, dynamic> json) {
  return Http()
    ..code = json['code'] as num
    ..msg = json['msg'] as String
    ..data = json['data'] as List;
}

Map<String, dynamic> _$HttpToJson(Http instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };
