import 'dart:convert';

class KategoriModel {
  int id;
  String nama;
  String icon;

  KategoriModel({this.id = 0, this.nama, this.icon, });

  factory KategoriModel.fromJson(Map<String, dynamic> map) {
    return KategoriModel(
        id: map["id"], nama: map["nama"], icon: map["icon"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "nama": nama, "icon": icon };
  }

  @override
  String toString() {
    return 'Kategori{id: $id, nama: $nama, icon: $icon}';
  }

}

List<KategoriModel> kategoriFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<KategoriModel>.from(data.map((item) => KategoriModel.fromJson(item)));
}

String kategoriToJson(KategoriModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}