import 'dart:convert';

class ProdukModel {
  int id;
  int idKategori;
  String nama;
  String deskripsi;
  String image;
  String harga;

  ProdukModel({
    this.id = 0,
    this.idKategori = 0,
    this.nama,
    this.deskripsi,
    this.image,
    this.harga,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> map) {
    return ProdukModel(
      id: map["id"],
      idKategori: map["idKategori"],
      nama: map["nama"],
      deskripsi: map["deskripsi"],
      image: map["image"],
      harga: map["harga"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "idKategori": idKategori,
      "nama": nama,
      "deskripsi": deskripsi,
      "image": image,
      "harga": harga,
    };
  }

  @override
  String toString() {
    return 'Produk{id: $id,idKategori: $idKategori, nama: $nama, deskripsi: $deskripsi, harga: $harga,image: $image,}';
  }
}

List<ProdukModel> produkFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ProdukModel>.from(data.map((item) => ProdukModel.fromJson(item)));
}

String produkToJson(ProdukModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
