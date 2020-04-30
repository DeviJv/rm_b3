import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rm_b3/widget/produk_listview.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Rumah Makan',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                letterSpacing: 1.5),
          ),
          leading: GestureDetector(
            onTap: () => ('Menu Di Pencet'),
            child: Icon(
              FontAwesomeIcons.hamburger,
              color: Colors.white,
              size: 20.0,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    FontAwesomeIcons.search,
                    color: Colors.white,
                    size: 20.0,
                  ),
                )),
          ],
          centerTitle: true,
          primary: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          height: 750.0,
          child: Produklistview(scrollaxis:1,), // jika 1 scrollaxis listview nya jadi vertical
        ),
      );
  }
}
