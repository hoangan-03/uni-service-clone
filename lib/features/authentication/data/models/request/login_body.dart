class LoginBody {
  final String email;
  final String password;

  LoginBody(this.email, this.password);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'email': email,
        'password': password,
      };
}