class RegisterBody {
  final String email;
  final String password;

  RegisterBody(this.email, this.password);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'email': email,
        'password': password,
      };
}
