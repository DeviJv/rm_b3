import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rm_b3/config/api.dart';
import 'package:rm_b3/main.dart';
import 'package:rm_b3/widget/bezierContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkout extends StatefulWidget {
  Checkout({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool _isLoading = false;
  bool _isTransfer = false;
  final _formKey = GlobalKey<FormState>();

  String _waktuMlm; //Ini untuk menyimpan value data gender
  String _waktuPagi;
  String _valuePayment;
  List _listMlm = ["06-09", "10-12", "13-15", "16-18"]; //Array gender
  List _listPagi = ["06-09", "10-12", "13-15", "16-18"];
  List _listPaymentMethod = ['Transfer', 'COD'];
  var name;
  var phone;
  var alamat;
  var patokan;
  var payment;

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
            Text('',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _bankAdmin() {
    return Column(
      children: <Widget>[
        Text(
          '*Silahkan Transfer Sebesar Rp 300,000 Ke No Rek 081233444 Bank Indonesia Atas Nama Jujum Dan \n Upload Bukti Pembayaran Pada Form Di Bawah Ini*',
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ],
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

  Widget _entryWaktuPengiriman() {
    var ifmlm = 18;
    var pagi = 06;
    var now = DateTime.now();
    var time = TimeOfDay.now();
    var dateMlm = DateTime(now.year, now.month, now.day + 1);
    var newdateMlm = DateFormat('yyyy-MM-dd').format(dateMlm);
    var newdatePagi = DateFormat('yyyy-MM-dd').format(now);
    var datejadi = '';
    if (time.hour > ifmlm) {
      datejadi = newdateMlm;
    } else {
      datejadi = newdatePagi;
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Waktu Pengiriman',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              DropdownButton(
                hint: Text("Mau Di Kirim Kapan?"),
                value: _waktuMlm,
                items: _listMlm.map((value) {
                  return DropdownMenuItem(
                    child: Text('$datejadi $value WIB'),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _waktuMlm = value;
                  });
                },
              ),
            ],
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
            'Alamat Pengiriman',
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

  Widget _entryUpload() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Bukti Foto',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: OutlineButton(
                  onPressed: chooseImage,
                  child: Text('Pilih Gambar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _entryPayment() {
    // if (time.hour > ifmlm) {
    //   datejadi = newdateMlm;
    // } else {
    //   datejadi = newdatePagi;
    // }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Pembayaran',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              DropdownButton(
                hint: Text("Mau Bayar Pake Apa?"),
                value: _valuePayment,
                items: _listPaymentMethod.map((value) {
                  return DropdownMenuItem(
                    child: Text('$value aja'),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valuePayment = value;
                    if(value == 'Transfer'){
                      _isTransfer = true;
                    }else{
                      _isTransfer = false;
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        // if (_formKey.currentState.validate()) {
        //   _register();
        // }
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
          _isLoading ? 'Proccessing...' : 'Bayar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  // Widget _loginAccountLabel() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 20),
  //     alignment: Alignment.bottomCenter,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Text(
  //           'Sudah Punya Akun ?',
  //           style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
  //         ),
  //         SizedBox(
  //           width: 10,
  //         ),
  //         InkWell(
  //           onTap: () {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => LoginPage()));
  //           },
  //           child: Text(
  //             'Login',
  //             style: TextStyle(
  //                 color: Color(0xfff79c4f),
  //                 fontSize: 13,
  //                 fontWeight: FontWeight.w600),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Form Pembayaran',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.headline1,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Color(0xffe46b10),
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _entryNama(),
          _entryPhone(),
          _entryWaktuPengiriman(),
          _entryAlamat(),
          _entryPayment(),
          Visibility(
            visible: _isTransfer,
            child: _entryUpload(),
          ),
        ],
      ),
    );
  }

  Future<File> file;
  String status = '';
  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
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
                margin: EdgeInsets.only(bottom: 50),
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
                      height: 40,
                    ),
                    _bankAdmin(),
                    SizedBox(
                      height: 30,
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
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: _loginAccountLabel(),
                    // ),
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
    var data = {'phone': phone, 'name': name, 'alamat': alamat};

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
