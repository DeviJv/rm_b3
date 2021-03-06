import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:rm_b3/models/kategori_mode.dart';
import 'package:rm_b3/models/produk_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Network{
  final String _url = 'http://192.168.43.63/api/public/api/v1';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  final int id;
  Client http = Client();
  Network({this.id});
  
  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'))['token'];
  }
  checkServer() async{
    var fullUrl = 'http://192.168.43.63:8080/api/public/api/v1';
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }
  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  Future<List<KategoriModel>> getkategori() async {
    final response = await http.get("$_url/getKategori");

    if (response.statusCode == 200) {
      return kategoriFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<ProdukModel>> produkByIdKategori(int id) async {
    final response = await http.get("$_url/getProdukByKategori/$id");

    if (response.statusCode == 200) {
      return produkFromJson(response.body);
    } else {
      return null;
    }
  }

  


  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}