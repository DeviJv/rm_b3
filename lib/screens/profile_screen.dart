import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        backgroundColor: Colors.blue,
        body: Container(
          child: Text('Halaman Profile'),
        ),
      ),
    );
  }
}
