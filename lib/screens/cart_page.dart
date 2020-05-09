import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rm_b3/bloc/cartListBloc.dart';
import 'package:rm_b3/bloc/listStyleColorBloc.dart';
import 'package:rm_b3/models/destination_model.dart';
import 'package:rm_b3/screens/checkout.dart';
import 'dart:core';

class CartPage extends StatelessWidget {
  // final Destination destination;

  // CartPage({Key key, this.destination}) : super(key: key);

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    List<Destination> destinations;
    return StreamBuilder(
      stream: bloc.listStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          destinations = snapshot.data;
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: CartBody(destinations),
              ),
            ),
            bottomNavigationBar: BottomBar(destinations),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class BottomBar extends StatelessWidget {
  final List<Destination> destinations;

  BottomBar(this.destinations);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(destinations),
          Divider(
            height: 1,
          ),
          // persons(),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Checkout(),
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width / 1,
              margin: EdgeInsets.only(right: 25),
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Color(0xfffeb324),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Mau Bayar Dong',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container persons() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Persons',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          CustomPersonWidget(),
        ],
      ),
    );
  }

  Container totalAmount(List<Destination> destination) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Total:',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
          ),
          Text(
            "\$${returnTotalAmount(destinations)}",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  String returnTotalAmount(List<Destination> destinations) {
    double totalAmount = 0.0;
    for (int i = 0; i < destinations.length; i++) {
      totalAmount = totalAmount + destinations[i].country * destinations[i].qty;
    }
    return totalAmount.toStringAsFixed(2);
  }
}

class CustomPersonWidget extends StatefulWidget {
  @override
  _CustomPersonWidgetState createState() => _CustomPersonWidgetState();
}

class _CustomPersonWidgetState extends State<CustomPersonWidget> {
  int noOfPerson = 1;
  double _buttonWidth = 30;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300], width: 2),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(),
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: _buttonWidth,
            height: _buttonWidth,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  if (noOfPerson > 1) {
                    noOfPerson--;
                  }
                });
              },
              child: Text(
                "-",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
          ),
          Text(
            noOfPerson.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: _buttonWidth,
            height: _buttonWidth,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  if (noOfPerson > 1) {
                    noOfPerson++;
                  }
                });
              },
              child: Text(
                "+",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartBody extends StatelessWidget {
  final List<Destination> destinations;
  CartBody(this.destinations);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          title(),
          Expanded(
            flex: 1,
            child:
                destinations.length > 0 ? destinationList() : noItemContainer(),
          ),
        ],
      ),
    );
  }

  Container noItemContainer() {
    return Container(
      child: Center(
          child: Text(
        'Pesanan Anda Masih Kosong',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
          fontSize: 20,
        ),
      )),
    );
  }

  ListView destinationList() {
    return ListView.builder(
      itemCount: destinations.length,
      itemBuilder: (builder, index) {
        return CartListItem(destination: destinations[index]);
      },
    );
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Pesanan',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                ),
              ),
              Text(
                'Saya',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 35,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartListItem extends StatelessWidget {
  final Destination destination;

  CartListItem({@required this.destination});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      maxSimultaneousDrags: 1,
      data: destination,
      child: DraggableChild(destination: destination),
      feedback: DraggableChildFeedBack(destination: destination),
      childWhenDragging: destination.qty > 1
          ? DraggableChild(destination: destination)
          : Container(),
    );
  }
}

class DraggableChild extends StatelessWidget {
  const DraggableChild({
    Key key,
    @required this.destination,
  }) : super(key: key);

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(destination: destination),
    );
  }
}

class DraggableChildFeedBack extends StatelessWidget {
  const DraggableChildFeedBack({
    Key key,
    @required this.destination,
  }) : super(key: key);

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();
    return Opacity(
      opacity: 0.7,
      child: Material(
        child: StreamBuilder<Object>(
            stream: colorBloc.colorStream,
            builder: (context, snapshot) {
              return Container(
                margin: EdgeInsets.only(bottom: 25),
                child: ItemContent(destination: destination),
                decoration: BoxDecoration(
                  color: snapshot.data != null ? snapshot.data : Colors.white
                ),
              );
            }),
      ),
    );
  }
}

class ItemContent extends StatelessWidget {
  final Destination destination;

  ItemContent({@required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image(
              image: AssetImage(destination.imageUrl),
              fit: BoxFit.fitHeight,
              height: 55,
              width: 80,
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(text: destination.qty.toString()),
                TextSpan(text: " X "),
                TextSpan(text: destination.city),
              ],
            ),
          ),
          Text(
            "\$${destination.qty * destination.country}",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(0),
          child: GestureDetector(
            child: Icon(
              CupertinoIcons.back,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        DragTargetWidget(),
      ],
    );
  }
}

class DragTargetWidget extends StatefulWidget {
  @override
  _DragTargetWidgetState createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  final CartListBloc listBloc = BlocProvider.getBloc<CartListBloc>();
  final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

  @override
  Widget build(BuildContext context) {
    return DragTarget<Destination>(
      onWillAccept: (Destination destination) {
        colorBloc.setColor(Colors.red);
        return true;
      },
      
      // onLeave: (Destination destination){
      //   colorBloc.setColor(Colors.white);
      // },
      onAccept: (Destination destination) {
        listBloc.removeFromList(destination); // Hapus Cart
        colorBloc.setColor(Colors.white);
      },
      builder: (context, incoming, rejected) {
        return Padding(
          padding: EdgeInsets.all(0.0),
          child: Icon(
            CupertinoIcons.delete,
            size: 30,
          ),
        );
      },
    );
  }
}
