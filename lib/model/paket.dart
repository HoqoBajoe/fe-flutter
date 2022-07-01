class Paket {
  int id;
  String nama_paket;
  List<String> destinasi_wisata;
  String deskripsi;
  List<String> photo_wisata;
  int harga;
  DateTime created_at;
  DateTime updated_at;

  Paket({
    required this.id,
    required this.nama_paket,
    required this.destinasi_wisata,
    required this.deskripsi,
    required this.photo_wisata,
    required this.harga,
    required this.created_at,
    required this.updated_at,
  });

  factory Paket.fromJson(Map<String, dynamic> json) {
    return Paket(
      id: json["id"],
      nama_paket: json["nama_paket"],
      destinasi_wisata:
          List<String>.from(json["destinasi_wisata"].map((x) => x)),
      deskripsi: json["deskripsi"],
      photo_wisata: List<String>.from(json["photo_wisata"].map((x) => x)),
      harga: json["harga"],
      created_at: DateTime.parse(json["created_at"]),
      updated_at: DateTime.parse(json["updated_at"]),
    );
  }
}
