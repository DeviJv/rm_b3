import 'package:flutter/material.dart';

import 'package:rm_b3/config/api.dart';
import 'package:rm_b3/models/kategori_mode.dart';
import 'package:transparent_image/transparent_image.dart';

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
      builder:
          (BuildContext context, AsyncSnapshot<List<KategoriModel>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<KategoriModel> kategoris = snapshot.data;
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Kategori',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              color: Colors.grey[800]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // GestureDetector(
                        //   onTap: () => ('see all'),
                        //   child: Text(
                        //     'Lihat Semua',
                        //     style: TextStyle(
                        //         fontSize: 13.0,
                        //         color: Theme.of(context).primaryColor,
                        //         letterSpacing: 1.5),
                        //   ),
                        // )
                      ],
                    ),
                    _buildListView(kategoris)
                  ],
                ),
              ),
            ),
          );
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
   var url = 'http://192.168.43.63:8080/api';

  return Container(
    height: 250,
    child: GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (context, index) {
        KategoriModel kategori = kategoris[index];
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: '${url}${kategori.icon}',
              ),
              // Text('${url}${kategori.icon}'),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    kategori.nama,
                    style: TextStyle(
                      color: Colors.grey[700],
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
