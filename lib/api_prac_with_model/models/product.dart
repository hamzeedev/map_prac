class Product {

  String name;
  String brand;
  int    id;
  String category;
  String thumbnail;
  double price;
  double rating;

  factory Product.fromMap(Map<String, dynamic> data){
    return Product(
      name:      data['name']       as String? ?? "",
      brand:     data['brand']      as String? ?? "Unknown",
      id:        data['id']         as int?    ?? 0,
      category:  data['category']   as String? ?? "Unknown",
      thumbnail: data['image_link'] as String? ?? "",
      price:     double.tryParse(data['price'].toString())  ?? 0,
      rating:    double.tryParse(data['rating'].toString()) ?? 0,
      

    );
  }

  Product({
    required this.name,
    required this.brand,
    required this.id,
    required this.category,
    required this.thumbnail,
    required this.price,
    required this.rating,
  });

}