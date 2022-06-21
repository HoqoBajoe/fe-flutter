class HistTrans {
  HistTrans({
    required this.namaPaket,
    required this.metode,
    required this.pax,
    required this.harga,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  String namaPaket;
  String metode;
  int pax;
  int harga;
  int total;
  String status;
  DateTime createdAt;

  factory HistTrans.fromJson(Map<String, dynamic> json) => HistTrans(
        namaPaket: json["nama_paket"],
        metode: json["metode"],
        pax: json["pax"],
        harga: json["harga"],
        total: json["total"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "nama_paket": namaPaket,
        "metode": metode,
        "pax": pax,
        "harga": harga,
        "total": total,
        "status": status,
        "created_at": createdAt.toIso8601String(),
      };
}
