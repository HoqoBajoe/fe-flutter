class ReviewUser {
  ReviewUser({
    required this.id,
    required this.nama,
    required this.namaPaket,
    required this.stars,
    required this.review,
    required this.status,
    required this.createdAt,
  });

  int id;
  String nama;
  String namaPaket;
  int stars;
  String review;
  String status;
  DateTime createdAt;

  factory ReviewUser.fromJson(Map<String, dynamic> json) => ReviewUser(
        id: json["id"],
        nama: json["nama"],
        namaPaket: json["nama_paket"],
        stars: json["stars"],
        review: json["review"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nama_paket": namaPaket,
        "stars": stars,
        "review": review,
        "status": status,
        "created_at": createdAt.toIso8601String(),
      };
}
