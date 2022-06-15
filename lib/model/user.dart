class User {
  int id;
  String nama;
  String email;
  String role;
  String token;

  User({
    required this.id,
    required this.nama,
    required this.email,
    required this.role,
    required this.token,
  });
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nama = json['nama'],
        email = json['email'],
        role = json['role'],
        token = json['token'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'email': email,
        'role': role,
        'token': token,
      };
}
