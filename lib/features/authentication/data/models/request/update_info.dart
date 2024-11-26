class UpdateInfoBody {
  final String birthdate;
  final String name;
  final String passwordl;

  UpdateInfoBody(this.birthdate, this.name, this.passwordl);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'birthdate': birthdate,
        'name': name,
        'password': passwordl,
      };
}
