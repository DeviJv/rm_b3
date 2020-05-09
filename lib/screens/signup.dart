import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rm_b3/main.dart';
import 'package:rm_b3/widget/bezierContainer.dart';
import 'package:rm_b3/screens/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rm_b3/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var name;
  var phone;
  var alamat;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Kembali',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryNama() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Nama Lengkap',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              hintText: "Nama Lengkap",
              hintStyle: TextStyle(
                  color: Color(0xFF9b9b9b),
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            validator: (nameValue) {
              if (nameValue.isEmpty) {
                return 'Masukan Nama Lengkap Anda';
              }
              name = nameValue;
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _entryEmail() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              hintText: "Email",
              hintStyle: TextStyle(
                  color: Color(0xFF9b9b9b),
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            validator: (emailValue) {
              if (emailValue.isEmpty) {
                return 'Masukan Email Anda';
              }
              email = emailValue;
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _entryPhone() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Phone',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              hintText: "Phone",
              hintStyle: TextStyle(
                  color: Color(0xFF9b9b9b),
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            validator: (phoneValue) {
              if (phoneValue.isEmpty) {
                return 'Masukan Nomor Hp Anda';
              }
              phone = phoneValue;
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _entryPassword() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Password',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.vpn_key,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              hintText: "Password",
              hintStyle: TextStyle(
                  color: Color(0xFF9b9b9b),
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            validator: (passwordValue) {
              if (passwordValue.isEmpty) {
                return 'Masukan Katasandi Anda';
              }
              password = passwordValue;
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _entryAlamat() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Alamat',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.streetview,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              hintText: "Alamat Lengkap",
              hintStyle: TextStyle(
                  color: Color(0xFF9b9b9b),
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            validator: (alamatValue) {
              if (alamatValue.isEmpty) {
                return 'Masukan Alamat Lengkap Anda';
              }
              alamat = alamatValue;
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        if (_formKey.currentState.validate()) {
          _register();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          _isLoading ? 'Proccessing...' : 'Daftar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sudah Punya Akun ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Sem',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline1,
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
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _entryNama(),
          _entryEmail(),
          _entryPhone(),
          _entryPassword(),
          _entryAlamat(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
            child: Container(
          height: 900,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(bottom:60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: SizedBox(),
                    ),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    // Expanded(
                    //   flex: 1,
                    //   child: SizedBox(),
                    // ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _loginAccountLabel(),
                    ),
                  ],
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
              Positioned(
                  top: -MediaQuery.of(context).size.height * .30,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer())
            ],
          ),
        )));
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
      'alamat': alamat
    };

    var res = await Network().authData(data, '/register');
    var body = json.decode(res.body);
    // print(body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => BottomNavigation()),
      );
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
