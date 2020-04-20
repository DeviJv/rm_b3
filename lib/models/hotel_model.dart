class Hotel {
  String imageUrl;
  String name;
  String address;
  String price;

  Hotel({
    this.imageUrl,
    this.name,
    this.address,
    this.price,
  });
}

final List<Hotel> hotels = [
  Hotel(
    imageUrl: 'assets/images/hotel0.png',
    name: 'Wisata 1',
    address: 'E.Sumawijaya Kab.Bogor',
    price: '175,000',
  ),
  Hotel(
    imageUrl: 'assets/images/hotel1.png',
    name: 'Wisata 2',
    address: 'E.Sumawijaya Kab.Bogor',
    price: '300,000',
  ),
  Hotel(
    imageUrl: 'assets/images/hotel2.png',
    name: 'Wisata 3',
    address: 'E.Sumawijaya Kab.Bogor',
    price: '240,000',
  ),
];
