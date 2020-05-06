import 'package:rm_b3/models/destination_model.dart';

class CartProvider {
  List<Destination> destinations = [];

  List<Destination> addToList(Destination destination) {
    bool isPresent = false;
    if (destinations.length > 0) {
      for (int i = 0; i < destinations.length; i++) {
        if (destinations[i].id == destination.id) {
          tambahQuantity(destination);
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }
      if (!isPresent) {
        destinations.add(destination);
      }
    } else {
      destinations.add(destination);
    }
    // destinations.add(destination);
    return destinations;
  }

  void tambahQuantity(Destination destination) => destination.tambahqty();
  void kurangQuantity(Destination destination) => destination.kurangqty();
  List<Destination> removeFromList(Destination destination) {
    if (destination.qty > 1) {
      kurangQuantity(destination);
    } else {
      destinations.remove(destination);
    }
    return destinations;
  }
}
