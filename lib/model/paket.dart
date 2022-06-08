// To parse this JSON data, do
//
//     final paket = paketFromJson(jsonString);

import 'dart:convert';

Paket paketFromJson(String str) => Paket.fromJson(json.decode(str));

String paketToJson(Paket data) => json.encode(data.toJson());

class Paket {
    Paket({
      required  this.data,
    });

    List<Datum> data;

    factory Paket.fromJson(Map<String, dynamic> json) => Paket(

        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
      required  this.id,
      required  this.namaPaket,
      required  this.destinasiWisata,
      required  this.deskripsi,
      required  this.photoWisata,
      required  this.harga,
      required  this.createdAt,
      required  this.updatedAt,
    });

    int id;
    String namaPaket;
    List<String> destinasiWisata;
    String deskripsi;
    List<String> photoWisata;
    int harga;
    DateTime createdAt;
    DateTime updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaPaket: json["nama_paket"],
        destinasiWisata: List<String>.from(json["destinasi_wisata"].map((x) => x)),
        deskripsi: json["deskripsi"],
        photoWisata: List<String>.from(json["photo_wisata"].map((x) => x)),
        harga: json["harga"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_paket": namaPaket,
        "destinasi_wisata": List<dynamic>.from(destinasiWisata.map((x) => x)),
        "deskripsi": deskripsi,
        "photo_wisata": List<dynamic>.from(photoWisata.map((x) => x)),
        "harga": harga,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
