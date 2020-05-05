class Activity {
  int id;
  int idProduk;
  String nama;
  int qty;

  Activity({
    this.id,
    this.idProduk,
    this.nama,
    this.qty,
  });
}

final List<Activity> activities = [
    Activity(
      id: 1,
      nama: 'gram',
      idProduk: 1,
      qty: 250,
    ),
    Activity(
      id: 2,
      nama: 'gram',
      idProduk: 1,
      qty: 500,
    ),
    Activity(
      id: 3,
      nama: 'gram',
      idProduk: 1,
      qty: 1000,
    ),
    Activity(
      id: 4,
      nama: 'gram',
      idProduk: 1,
      qty: 2000,
    ),
    Activity(
      id: 5,
      nama: 'liter',
      idProduk: 2,
      qty: 1,
    ),

  ];