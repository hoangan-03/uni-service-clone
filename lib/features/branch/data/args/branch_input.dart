class Branch {
  final String name;

  Branch({required this.name});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      name: json['name'],
    );
  }
}
