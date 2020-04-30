import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rm_b3/screens/search_screen.dart';
// import 'package:rm_b3/models/destination_model.dart';
import 'package:rm_b3/widget/produk_listview.dart';
import 'package:rm_b3/widget/hotel_carousel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  // int _currentTab = 0;
  
  List<IconData> _icons = [
    
    FontAwesomeIcons.listUl,
    FontAwesomeIcons.utensils,
    FontAwesomeIcons.coffee,
    FontAwesomeIcons.campground,
  ];

  Widget _buildIcon(int index) {
    return GestureDetector(
      //gestur tap detection
      onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchScreen(
                        // destination: destination,
                      ),
                    ),
                  ),
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? Theme.of(context).accentColor
              : Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          _icons[index],
          size: 25.0,
          color: _selectedIndex == index
              ? Theme.of(context).primaryColor
              : Color(0xFFB4C1C4),
        ),
      ),
    );
  }

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
        body: SafeArea(
            child: ListView(
          // listView Atas
          padding: EdgeInsets.symmetric(vertical: 15.0), //margin top
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 18.0, right: 120.0),
              child: Text(
                'Mau Pesan Makanan Khas Daerah Murah?', //Test Header
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                  // color: Color(0)
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              //import loop icon from cunstrctor
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _icons
                  .asMap()
                  .entries
                  .map(
                    (MapEntry map) => _buildIcon(map.key), // Import Icons
                  )
                  .toList(),
            ),
            SizedBox(height: 20.0),
            Produklistview(),
            SizedBox(height: 20.0),
            HotelCarousel(),
          ],
        )),
        
        );
  }
}
