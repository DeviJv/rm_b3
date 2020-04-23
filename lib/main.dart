import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rm_b3/screens/home_screen.dart';
import 'package:rm_b3/screens/profile_screen.dart';
import 'package:rm_b3/screens/search_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rumah Makan B3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      home: BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentPage = 0;

  final List<Widget> _children = [
    //inport halaman content
    HomePage(),
    SearchScreen(),
    ProfileScreen(),
  ];

  // void getData() {
  //   databaseReference
  //       .collection("menu")
  //       .getDocuments()
  //       .then((QuerySnapshot snapshot) {
  //     snapshot.documents.forEach((f) => print('${f.data}}'));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
        currentIndex: _currentPage,
        items: [
          BottomNavigationBarItem(
            title: SizedBox.shrink(),
            icon: Icon(Icons.home, size: 30.0),
          ),
          BottomNavigationBarItem(
            title: SizedBox.shrink(),
            icon: Icon(Icons.local_pizza, size: 30.0),
          ),
          BottomNavigationBarItem(
              title: SizedBox.shrink(),
              icon: CircleAvatar(
                radius: 15.0,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 15.0,
                      ),
                      child: Icon(
                        FontAwesomeIcons.shoppingBasket,
                        size: 22.0,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(33.0, 0.0, 0.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.redAccent,
                        ),
                        child: Text(
                          '0',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            // backgroundColor: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
