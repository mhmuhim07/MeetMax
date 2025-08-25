class User {
  final String name;
  final String email;
  String password;
  final String birthDate; //dd/mm/yy
  bool isHashed;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.birthDate,
    this.isHashed = false,
  });
}
