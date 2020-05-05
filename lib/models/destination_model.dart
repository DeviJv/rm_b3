
class Destination {
  int id;
  String imageUrl;
  String city;
  int country;
  String description;
  int qty;

  Destination({
    this.id,
    this.imageUrl,
    this.city,
    this.country,
    this.description,
    this.qty = 1,
  });
  void tambahqty() {
    this.qty = this.qty + 1;
  }

  void kurangqty() {
    this.qty = this.qty - 1;
  }
}



List<Destination> destinations = [
  Destination(
    id: 1,
    imageUrl: 'assets/images/paket_nyawah.png',
    city: 'Beras',
    country: 150, // harga
    description: 'Paket Nyawah Termirah Seduniah.',
   
    
  ),
  Destination(
    id: 2,
    imageUrl: 'assets/images/paket_nyawah.png',
    city: 'Minyak',
    country: 50, // harga
    description: 'Paket Nyawah Termirah Seduniah.',
   
    
  ),
  Destination(
    id: 3,
    imageUrl: 'assets/images/paket_nyawah.png',
    city: 'Gula',
    country: 10, // harga
    description: 'Paket Nyawah Termirah Seduniah.',
   
    
  ),
  // Destination(
  //   id: 1,
  //   imageUrl: 'assets/images/Ayam_Geprek.png',
  //   city: 'Ayam Geprek',
  //   country: 'Rp 80,000',
  //   description: 'Ayam Geprek + Kejo.',
  //   activities: activities,
  //   satuan: 'Liter',

  // ),
  // Destination(
  //   id: 2,
  //   imageUrl: 'assets/images/Sate_Ayam.png',
  //   city: 'Sate Ayam',
  //   country: 'Rp 60,000',
  //   description: 'Sate Ayam 20 Tusuk + Kejo.',
  //   activities: activities,
  //   satuan: 'Liter',

  // ),
  // Destination(
  //   id: 3,
  //   imageUrl: 'assets/images/es_teler.png',
  //   city: 'Es Teler',
  //   country: 'Rp 20,000',
  //   description: 'Es Teler Tersegarrrrr Syeduniaaaaa.',
  //   activities: activities,
  //   satuan: 'Liter',

  // ),
  // Destination(
  //   id: 4,
  //   imageUrl: 'assets/images/teh_manis.png',
  //   city: 'Es Teh Manis',
  //   country: 'Rp 10,000',
  //   description: 'Es Teh Manis Termaniss Syeduniaaaaaa.',
  //   activities: activities,
  //   satuan: 'Liter',

  // ),
];
