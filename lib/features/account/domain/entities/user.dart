
import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class User with PrettyJsonMixin{
  String? id = '';
  String? username = '';
  String? identificationCard= '';
  String? birthdate='';
  String? school='';
  String? faculty='';
  String? position='';
  String? role='';
  String? email = '';
  String? phone='';
  String? avatar='';
}
