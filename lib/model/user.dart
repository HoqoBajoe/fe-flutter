class User {
  int? id;
  String? nama;
  String? email;
  String? role;
  String? token;

  User({
    this.id,
    this.nama,
    this.email,
    this.role,
    this.token,
  });
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nama = json['nama'],
        email = json['email'],
        role = json['role'],
        token = json['token'];

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'email': email,
      };
}
