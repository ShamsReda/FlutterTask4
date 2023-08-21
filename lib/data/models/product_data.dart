class Product {
  int id;
  String title;
  String description;
  int price;
  String thumbnail;

  Product({
    required this.id,
    required this.price,
    required this.description,
    required this.title,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      thumbnail: json['thumbnail'],
    );
  }
}
