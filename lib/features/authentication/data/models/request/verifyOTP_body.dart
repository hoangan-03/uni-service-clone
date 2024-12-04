// ignore_for_file: file_names

class VerifyOTPBody {
  final String email;
  final String otp;
  VerifyOTPBody(this.email, this.otp);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'email': email,
        'otp': otp,
      };
}
