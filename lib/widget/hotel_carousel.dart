import 'package:flutter/material.dart';

import 'package:rm_b3/models/hotel_model.dart';

class HotelCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      //content list View Horizontal Scroll
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Top Wisata',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.grey[800]),
              ),
              GestureDetector(
                onTap: () => ('see all'),
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
        Container(
          height: 300.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hotels.length,
              itemBuilder: (BuildContext context, int index) {
                Hotel hotel = hotels[index];
                return Container(
                  margin: EdgeInsets.all(10.0),
                  width: 210.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 22.0,
                        child: Container(
                          height: 120.0,
                          width: 210.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                                  child: Text(
                                    hotel.name,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.0),
                                  ),
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal:3.0),
                                  child: Text(hotel.address,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      )),
                                ),
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
                              child: Image(
                                height: 180.0,
                                width: 180.0,
                                image: AssetImage(hotel.imageUrl),
                                fit: BoxFit.cover,
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
                                        'Rp ${hotel.price}',
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
              }),
        ),
      ],
    );
  }
}
