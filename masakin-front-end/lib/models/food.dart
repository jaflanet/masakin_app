class Food {
  final String photo;
  final String menuTitle;
  final num price;
  final String type;

  const Food({
    required this.photo,
    required this.menuTitle,
    required this.price,
    required this.type,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        photo: json['photo'],
        menuTitle: json['menuTitle'],
        price: json['price'],
        type: json['type']
      );

  Map<String, dynamic> toJson() => {
        'photo': photo,
        'menuTitle': menuTitle,
        'price': price,
        'type' : type,
      };

  // static const List<Food> generatedFood = [
  //   Food(
  //       imgUrl:
  //           'https://www.resepistimewa.com/wp-content/uploads/cara-membuat-ayam-bakar-kecap.jpg',
  //       name: 'Ayam Bakar',
  //       price: 20000),
  //   Food(
  //       imgUrl:
  //           'https://selerasa.com/wp-content/uploads/2015/12/images_daging_ayam-goreng-1200x720.jpg',
  //       name: 'Ayam goreng',
  //       price: 16000),
  //   Food(
  //       imgUrl:
  //           'https://img-global.cpcdn.com/recipes/7fa7fdc21d48af83/680x482cq70/nasi-ayam-bakar-foto-resep-utama.jpg',
  //       name: 'Paket Ayam Bakar',
  //       price: 24000),
  //   Food(
  //       imgUrl:
  //           'https://sajilicious.com/wp-content/uploads/2020/06/Sajilicious_nasi-ayam-goreng-berempah-Shah-Alam.jpg',
  //       name: 'Paket Ayam goreng',
  //       price: 22000),
  // ];
}
