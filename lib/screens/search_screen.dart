import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rm_b3/widget/produk_listview.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          height: 750.0,
          child: Produklistview(scrollaxis:1,), // jika 1 scrollaxis listview nya jadi vertical
        ),
      );
  }
}
