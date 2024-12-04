// ignore_for_file: file_names

class GetOTPBody {
  String? email;
  GetOTPBody(this.email);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'email': email,
      };
}
