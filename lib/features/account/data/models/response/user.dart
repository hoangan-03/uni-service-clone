import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class UserApiModel {
  String? id = '';
  String? username = '';
  String? identificationCard = '';
  String? birthdate = '';
  String? school = '';
  String? faculty = '';
  String? position = '';
  String? role = '';
  String? email = '';
  String? phone = '';
  String? avatar = '';
  int? point = 0;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'username': username,
        'identificationCard': identificationCard,
        'birthdate': birthdate,
        'school': school,
        'faculty': faculty,
        'position': position,
        'role': role,
        'email': email,
        'phone': phone,
        'avatar': avatar,
        'point': point,
      };
}
