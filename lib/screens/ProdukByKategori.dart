import 'package:animations/animations.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rm_b3/bloc/cartListBloc.dart';
import 'package:rm_b3/config/api.dart';
import 'package:rm_b3/models/destination_model.dart';
import 'package:rm_b3/models/produk_model.dart';
import 'package:transparent_image/transparent_image.dart';

import 'cart_page.dart';

const double _fabDimension = 56.0;

class ProdukByKategori extends StatefulWidget {
  final int id;

  const ProdukByKategori({Key key, this.id}) : super(key: key);

  @override
  _ProdukByKategoriState createState() => _ProdukByKategoriState();
}

class _ProdukByKategoriState extends State<ProdukByKategori>
    with TickerProviderStateMixin {
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  Network network;
  void initState() {
    super.initState();
    network = Network();
  }

  @override
  Widget build(BuildContext context) {
    // Network().getkategori().then((value) => print("value: $value"));
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

    return FutureBuilder(
      future: network.produkByIdKategori(widget.id),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProdukModel>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<ProdukModel> produks = snapshot.data;
          return Scaffold(
            extendBody: true,
            body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
                    child: Column(
                      children: <Widget>[
                        AppBar(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'ListProduk',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5),
                              )
                            ],
                          ),
                        ),
                        ListProduk(produks: produks),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: OpenContainer(
              closedColor: Colors.amber,
              transitionType: _transitionType,
              openBuilder: (BuildContext context, VoidCallback _) {
                return CartPage();
              },
              closedElevation: 6.0,
              closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(_fabDimension / 2),
                ),
              ),
              closedBuilder:
                  (BuildContext context, VoidCallback openContainer) {
                return SizedBox(
                  height: _fabDimension,
                  width: _fabDimension,
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
                                padding:
                                    EdgeInsets.fromLTRB(33.0, 0.0, 0.0, 0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.redAccent,
                                  ),
                                  child: StreamBuilder(
                                      stream: bloc.listStream,
                                      builder: (context, snapshot) {
                                        List<Destination> destinations =
                                            snapshot.data;
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
                );
              },
            ),
          );
        } else {
          return Center(
            child: LinearProgressIndicator(),
          );
        }
      },
    );
  }
}

class ListProduk extends StatelessWidget {
  const ListProduk({
    Key key,
    @required this.produks,
  }) : super(key: key);

  final List<ProdukModel> produks;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: produks != null ? BuildListView(produks) : NoProdukContainer(),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            CupertinoIcons.back,
            size: 30,
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class NoProdukContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 230,
      ),
      child: Text(
        'Produk Tidak Di Temukan',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.grey,
          fontSize: 20,
        ),
      ),
    );
  }
}

class BuildListView extends StatelessWidget {
  final List<ProdukModel> produks;

  BuildListView(this.produks);

  @override
  Widget build(BuildContext context) {
    var url = 'http://192.168.43.63/api';
    return Container(
      height: MediaQuery.of(context).size.height / 1,
      child: GridView.builder(
        // physics: NeverScrollableScrollPhysics(),
        controller: new ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: produks.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: (4 / 4.5)),
        itemBuilder: (context, index) {
          ProdukModel produk = produks[index];
          return Container(
            margin: EdgeInsets.all(10.0),
            width: 210.0,
            // height: 2,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    height: 120.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: 3.0),
                            child: Text(
                              produk.nama,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0),
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(horizontal: 3.0),
                          //   child: Text(produk.deskripsi,
                          //       style: TextStyle(
                          //         color: Colors.grey,
                          //       )),
                          // ),
                          SizedBox(
                            height: 4.0,
                          ),
                          // Text(
                          //   '\$${hotel.price} / night',
                          //   style: TextStyle(
                          //       fontSize: 18.0,
                          //       fontWeight: FontWeight.w600),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ]),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: '${url}${produk.image}',
                          fit: BoxFit.cover,
                          height: 160,
                          width: 160,
                        ),
                      ),
                      Positioned(
                        right: 10.0,
                        top: 10.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  'Rp ${produk.harga}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Icon(
                            //       FontAwesomeIcons.locationArrow,
                            //       size: 10.0,
                            //       color: Colors.white,
                            //     ),
                            //     SizedBox(width: 5.0),
                            //     Text(
                            //       destination.country,
                            //       style: TextStyle(
                            //           color: Colors.white,
                            //           letterSpacing: 1.2),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
