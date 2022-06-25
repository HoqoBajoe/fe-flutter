class Transaction {
  Transaction({
    required this.idUser,
    required this.idPaketWisata,
    required this.metode,
    required this.pax,
    required this.total,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  int idUser;
  int idPaketWisata;
  String metode;
  String pax;
  int total;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        idUser: json["id_user"],
        idPaketWisata: json["id_paket_wisata"],
        metode: json["metode"],
        pax: json["pax"],
        total: json["total"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "id_paket_wisata": idPaketWisata,
        "metode": metode,
        "pax": pax,
        "total": total,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
