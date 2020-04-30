
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rm_b3/screens/cart_page.dart';
// import 'package:rm_b3/models/destination_model.dart';
import 'package:rm_b3/screens/home_screen.dart';
// import 'package:rm_b3/screens/loginPage.dart';
import 'package:rm_b3/screens/profile_screen.dart';
import 'package:rm_b3/screens/search_screen.dart';
import 'package:rm_b3/screens/welcomePage.dart';
import 'events/cart_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isLoggIn;

  const MyApp({Key key, this.isLoggIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartBloc>(
      child: MaterialApp(
        title: 'Rumah Makan B3',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        home: CheckAuth(),
      ),
      create: (BuildContext context) {
        return CartBloc();
      },
    );
  }
}


class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null){
      setState(() {
        isAuth = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = BottomNavigation();
    } else {
      child = WelcomePage();
    }
    return Scaffold(
      body: child,
    );
  }
}

class BottomNavigation extends StatefulWidget {
  final int destinationId;

  const BottomNavigation({Key key, this.destinationId}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentPage = 0;
  String name;

  // const _destinationId = widget.id;
  final List<Widget> _children = [
    //inport halaman content
    HomePage(),
    SearchScreen(),
    ProfileScreen(),
  ];
  
  
  @override

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
    var bloc = Provider.of<CartBloc>(context);
    int totalCount = 0;
    if (bloc.cart.length > 0) {
      totalCount = bloc.cart.values.reduce((a, b) => a + b);
    }
    // print(widget.destinationId);
    return Scaffold(
      extendBody: true, //fixed height jika Punya list view builder
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,

      body:  _children[_currentPage],
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
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CartPage(
              // destination: destination,
            ),
          ),
        ),
        heroTag: widget.destinationId,
        backgroundColor: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 15.0,
                      ),
                      child: Icon(
                        FontAwesomeIcons.shoppingCart,
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
                          '$totalCount',
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
