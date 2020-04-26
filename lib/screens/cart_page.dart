import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rm_b3/events/cart_bloc.dart';
import 'package:rm_b3/models/destination_model.dart';
import 'package:rm_b3/screens/menu_screen.dart';

class CartPage extends StatelessWidget {
  final Destination destination;

  CartPage({Key key, this.destination}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    var cart = bloc.cart;
    if (cart.length == 0) {
      Navigator.pop(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pesanan Anda",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        // height: 550.0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              int cartId = cart.keys.toList()[index];
              int count = cart[cartId];
              Destination destination = destinations[cartId];

              return ListTile(
                leading: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MenuScreen(
                        destination: destination,
                      ),
                    ),
                  ),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(destination.imageUrl),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                title: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(destination.city),
                    Text('Qty: $count'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  iconSize: 20.0,
                  color: Colors.red,
                  // elevation: 1.0,
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    bloc.clear(cartId);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
