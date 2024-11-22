class GetOTPBody {
  final String email;
  GetOTPBody(this.email);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'email': email,
      };
}
