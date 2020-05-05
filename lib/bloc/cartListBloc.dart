import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rm_b3/bloc/provider.dart';
import 'package:rm_b3/models/destination_model.dart';
import 'package:rxdart/rxdart.dart';

class CartListBloc extends BlocBase {
  CartListBloc();

  var _listController = BehaviorSubject<List<Destination>>.seeded([]);

//provider class
  CartProvider provider = CartProvider();

//output
  Stream<List<Destination>> get listStream => _listController.stream;

//input
  Sink<List<Destination>> get listSink => _listController.sink;

  addToList(Destination destination) {
    listSink.add(provider.addToList(destination));
  }

  removeFromList(Destination destination) {
    listSink.add(provider.removeFromList(destination));
    
  }

//dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _listController.close();
    super.dispose();
  }
}