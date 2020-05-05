import 'package:flutter/material.dart';

import 'package:rm_b3/config/api.dart';
import 'package:rm_b3/models/kategori_mode.dart';

class Kategori extends StatefulWidget {
  @override
  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  Network network;

  void initState() {
    super.initState();
    network = Network();
  }

  @override
  Widget build(BuildContext context) {
    // Network().getkategori().then((value) => print("value: $value"));

    return FutureBuilder(
      future: network.getkategori(),
      builder: (BuildContext context, AsyncSnapshot<List<KategoriModel>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<KategoriModel> kategoris = snapshot.data;
          return _buildListView(kategoris);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Widget _buildListView(List<KategoriModel> kategoris) {
    return Container(
      height: 500.0,
      child: ListView.builder(
        itemBuilder: (context, index) {
          KategoriModel kategori = kategoris[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  kategori.nama,
                  style: Theme.of(context).textTheme.title,
                ),
                Text(kategori.icon),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: null,
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    FlatButton(
                      onPressed: null,
                      child: Text(
                        "Edit",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: kategoris.length,
      ),
    );
  }
