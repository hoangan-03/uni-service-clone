class UpdateInfoBody {
  String birthdate;
  String name;
  String password;

  UpdateInfoBody(this.birthdate, this.name, this.password);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'birthdate': birthdate,
        'name': name,
        'password': password,
      };
}
