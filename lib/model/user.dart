class User {
  int? id;
  String username;
  String? password;
  String nama;
  String tingkatSekolah;

  User({
    this.id,
    required this.username,
    this.password,
    required this.nama,
    required this.tingkatSekolah,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      nama: json['nama'],
      tingkatSekolah: json['tingkatSekolah'],
    );
  }
}
