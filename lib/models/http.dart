import 'package:json_annotation/json_annotation.dart';

part 'http.g.dart';

@JsonSerializable()
class Http {
    Http();

    num code;
    String msg;
    List data;
    
    factory Http.fromJson(Map<String,dynamic> json) => _$HttpFromJson(json);
    Map<String, dynamic> toJson() => _$HttpToJson(this);
}
