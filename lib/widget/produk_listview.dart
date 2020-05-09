import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rm_b3/models/destination_model.dart';
import 'package:rm_b3/screens/menu_screen.dart';
import 'package:rm_b3/screens/search_screen.dart';

class Produklistview extends StatelessWidget {
  final int scrollaxis;

  const Produklistview({Key key, this.scrollaxis}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      //content list View Horizontal Scroll
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Visibility(
            visible: scrollaxis == 1 ? false : true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'KEBUTUHAN POKOK',
                  style: TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.grey[800]),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchScreen(
                          // destination: destination,
                          ),
                    ),
                  ),
                  child: Text(
                    'Lihat Semua',
                    style: TextStyle(
                        fontSize: 13.0,
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 1.5),
                  ),
                )
              ],
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Visibility(
                visible: scrollaxis == 1 ? true : false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    enableSuggestions: true,
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      // hasFloatingPlaceholder: true,
                      icon: Icon(
                        Icons.search,
                        size: 25.0,
                      ),
                      hintText: 'Cari Yang Kamu Disini!',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              // color: Colors.red,
              height: scrollaxis == 1 ? 550 : 280.0,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection:
                      scrollaxis == 1 ? Axis.vertical : Axis.horizontal,
                  itemCount: destinations.length,
                  itemBuilder: (BuildContext context, int index) {
                    Destination destination = destinations[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MenuScreen(
                            destination: destination,
                          ),
                        ),
                      ),
                      child: Container(
                        margin: scrollaxis == 1
                            ? EdgeInsets.all(10.0)
                            : EdgeInsets.all(10.0),
                        width: 210.0,
                        height: 250.0,
                        // color: Colors.red,
                        child: Stack(
                          alignment: scrollaxis == 1
                              ? Alignment.topCenter
                              : Alignment.topCenter,
                          children: <Widget>[
                            Positioned(
                              bottom: scrollaxis == 1 ? 0.0 : 15.0,
                              top: scrollaxis == 1 ? 100 : 125.0,
                              child: Container(
                                height: 120.0,
                                width: scrollaxis == 1 ? 380.0 : 200.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Text(
                                      //   '${destination.activities.length} activities',
                                      //   style: TextStyle(
                                      //       fontSize: 22.0,
                                      //       fontWeight: FontWeight.w600,
                                      //       letterSpacing: 1.2),
                                      // ),
                                      Text(destination.description,
                                          style: TextStyle(color: Colors.grey)),
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
                                  Hero(
                                    tag: destination.id,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18.0),
                                      child: Image(
                                        height: 180.0,
                                        width: scrollaxis == 1 ? 340.0 : 180.0,
                                        image: AssetImage(destination.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.0,
                                    bottom: 10.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(destination.city,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2)),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.locationArrow,
                                              size: 10.0,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 5.0),
                                            Text(
                                              destination.country.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: 1.2),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
