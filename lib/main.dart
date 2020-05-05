import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rm_b3/bloc/cartListBloc.dart';
import 'package:rm_b3/models/destination_model.dart';
import 'package:rm_b3/screens/cart_page.dart';
import 'package:rm_b3/screens/home_screen.dart';
import 'package:rm_b3/screens/profile_screen.dart';
import 'package:rm_b3/screens/search_screen.dart';
import 'package:rm_b3/screens/welcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isLoggIn;

  const MyApp({Key key, this.isLoggIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => CartListBloc()),
      ],
      child: MaterialApp(
        title: '',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xfffbb448),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        home: BottomNavigation(), //change to CheckAuth if Want Login
      ),
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

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
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

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  int _currentPage = 0;
  String name;
  AnimationController _controller;
  Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);

    _controller.forward();
  }

  final List<Widget> _children = [
    //inport halaman content
    HomePage(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _appBar() {
    return AppBar(
      title: RichText(
        text: TextSpan(
            text: 'Sem',
            style: GoogleFonts.portLligatSans(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10),
            ),
            children: [
              TextSpan(
                text: 'ba',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              TextSpan(
                text: 'ko',
                style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
              ),
            ]),
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
                FontAwesomeIcons.bell,
                color: Colors.white,
                size: 20.0,
              ),
            )),
      ],
      centerTitle: true,
      primary: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    return Scaffold(
      appBar: _appBar(),
      extendBody: true, //fixed height jika Punya list view builder
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: ScaleTransition(
        scale: _animation,
        alignment: Alignment.center,
        child: _children[_currentPage], //inject animation to body
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentPage = index;

            _controller = AnimationController(
                duration: const Duration(milliseconds: 1000),
                vsync: this,
                value: 0.6);
            _animation =
                CurvedAnimation(parent: _controller, curve: Curves.bounceIn);

            _controller.forward();
          });
        },
        currentIndex: _currentPage,
        items: [
          BottomNavigationBarItem(
            title: SizedBox.shrink(),
            icon: Icon(Icons.shopping_basket, size: 30.0),
          ),
          BottomNavigationBarItem(
            title: SizedBox.shrink(),
            icon: Icon(Icons.pie_chart_outlined, size: 30.0),
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
                        child: StreamBuilder(
                            stream: bloc.listStream,
                            builder: (context, snapshot) {
                              List<Destination> destinations = snapshot.data;
                              int length = destinations != null
                                  ? destinations.length
                                  : 0;
                              return Text(
                                length.toString(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  // backgroundColor: Colors.redAccent,
                                ),
                              );
                            }),
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
