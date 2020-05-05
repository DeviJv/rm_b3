import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rm_b3/bloc/cartListBloc.dart';
// import 'package:rm_b3/events/cart_bloc.dart';
// import 'package:rm_b3/main.dart';
import 'package:rm_b3/models/activity_model.dart';
import 'package:rm_b3/models/destination_model.dart';

class MenuScreen extends StatefulWidget {
  final Destination destination;
  MenuScreen({this.destination});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<bool> _wishlist = [false];

  List<Activity> activity = activities;

  // int id =0;
  // Text _buildRatingStars(int rating) {
  //   String stars = '';
  //   for (int i = 0; i < rating; i++) {
  //     stars += '⭐ ';
  //   }
  //   stars.trim();
  //   return Text(stars);
  // }

  // _addWishList() {
  //   setState(() {
  //     this._wishlist = true;
  //   });
  // }
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  int _newValue; //New Value SatuanData
  addToCart(Destination destination) {
    // List<Destination> destinations;
    // List newCartData = [];
    // for (final i in produk) {
    //   var cartDataMap = {
    //     'id': i.id,
    //     'imageUrl': i.imageUrl,
    //     'city': i.city,
    //     'country': i.country,
    //     'description': i.description,
    //     'qty': i.qty,
    //     'satuan': _newValue,
    //   };
    //   newCartData.add(cartDataMap); // Push new Value Data Satuan
    // }
    bloc.addToList(widget.destination);
  }

  @override
  Widget build(BuildContext context) {
    var satuanData = activity.where((activity) =>
        activity.idProduk ==
        widget.destination.id); //filter data where idProduk

    return Scaffold(
      body: Builder(
        builder: (context) =>
            Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ]),
                      child: Hero(
                        tag: widget.destination.id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image(
                            image: AssetImage(
                              widget.destination.imageUrl,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: 30.0,
                          color: Colors.white,
                          onPressed: () => Navigator.pop(context),
                        ),
                        Row(
                          children: <Widget>[
                            ToggleButtons(
                              color: Colors.white,
                              selectedColor: Colors.pink,
                              renderBorder: false,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(200),
                                bottomRight: Radius.circular(200),
                                topLeft: Radius.circular(200),
                                topRight: Radius.circular(200),
                              ),
                              children: <Widget>[
                                Icon(FontAwesomeIcons.solidHeart)
                              ],
                              isSelected: _wishlist,
                              onPressed: (int toggle) {
                                setState(() {
                                  _wishlist[toggle] = !_wishlist[toggle];
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20.0,
                    bottom: 20.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.destination.city,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2)),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.locationArrow,
                              size: 15.0,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              widget.destination.country.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.2,
                                fontSize: 22.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20.0,
                    bottom: 20.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 13.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.redAccent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(9.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    addToCart(widget.destination);

                                  },
                                  child: Icon(
                                    FontAwesomeIcons.shoppingCart,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), //gambar atas detail
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    DropdownButton(
                      isExpanded: true,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      hint: Text(
                        "-- Silahkan Pilih Quantity --",
                        textAlign: TextAlign.center,
                      ),
                      value: _newValue,
                      items: satuanData.map((value) {
                        return DropdownMenuItem(
                          child: Text(
                            '${value.qty} ${value.nama}',
                            textAlign: TextAlign.center,
                          ),
                          value: value.id,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _newValue = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: RaisedButton(
                        onPressed: () {
                          addToCart(widget.destination);
                          final snackbar = SnackBar(
                            content: Text("${widget.destination.city} Telah DiTambah"),
                            duration: Duration(milliseconds: 550),
                          );
                          Scaffold.of(context).showSnackBar(snackbar);
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Mau Dong',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
