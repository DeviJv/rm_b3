import 'package:rm_b3/models/activity_model.dart';

class Destination {
  int id;
  String imageUrl;
  String city;
  String country;
  String description;
  List<Activity> activities;

  Destination({
    this.id,
    this.imageUrl,
    this.city,
    this.country,
    this.description,
    this.activities,
  });
}

List<Activity> activities = [
  Activity(
    imageUrl: 'assets/images/a.png',
    name: 'Wisata KBS',
    type: 'Outbound',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: '300,000',
  ),
  Activity(
    imageUrl: 'assets/images/b.png',
    name: 'Wisata KBS',
    type: 'Outbound',
    startTimes: ['11:00 pm', '1:00 pm'],
    rating: 4,
    price: '210,000',
  ),
  Activity(
    imageUrl: 'assets/images/c.png',
    name: 'Wisata KBS',
    type: 'Outbound',
    startTimes: ['12:30 pm', '2:00 pm'],
    rating: 3,
    price: '125,000',
  ),
];

List<Destination> destinations = [
  Destination(
    id: 0,
    imageUrl: 'assets/images/paket_nyawah.png',
    city: 'Paket Nyawah',
    country: 'Rp 150,000',
    description: 'Paket Nyawah Termirah Seduniah.',
    activities: activities,
  ),
  Destination(
    id: 1,
    imageUrl: 'assets/images/Ayam_Geprek.png',
    city: 'Ayam Geprek',
    country: 'Rp 80,000',
    description: 'Ayam Geprek + Kejo.',
    activities: activities,
  ),
  Destination(
    id: 2,
    imageUrl: 'assets/images/Sate_Ayam.png',
    city: 'Sate Ayam',
    country: 'Rp 60,000',
    description: 'Sate Ayam 20 Tusuk + Kejo.',
    activities: activities,
  ),
  Destination(
    id: 3,
    imageUrl: 'assets/images/es_teler.png',
    city: 'Es Teler',
    country: 'Rp 20,000',
    description: 'Es Teler Tersegarrrrr Syeduniaaaaa.',
    activities: activities,
  ),
  Destination(
    id: 4,
    imageUrl: 'assets/images/teh_manis.png',
    city: 'Es Teh Manis',
    country: 'Rp 10,000',
    description: 'Es Teh Manis Termaniss Syeduniaaaaaa.',
    activities: activities,
  ),
];
