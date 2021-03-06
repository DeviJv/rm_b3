import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rm_b3/models/destination_model.dart';

class SliderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Destination> destination = destinations;

    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width / 1,
      child: Column(
        
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              
              aspectRatio:  16 / 9,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            ),
            items: destination
                .map(
                  (item) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage(item.imageUrl),
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 1,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
