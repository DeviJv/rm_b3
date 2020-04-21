import 'package:flutter/material.dart';
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

  void onTappedBar(int index) {}

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
              icon: Icon(Icons.search, size: 30.0),
            ),
            BottomNavigationBarItem(
                title: SizedBox.shrink(),
                icon: CircleAvatar(
                  radius: 15.0,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                )),
          ],
        ));
  }
}
