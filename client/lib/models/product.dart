class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String brand;
  final String category;
  final bool inStock;
  final List<Map<String, String>> images;
  final List<String> reviews;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.brand,
    required this.category,
    required this.inStock,
    required this.images,
    required this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] is num ? json['price'].toDouble() : 0.0),
      brand: json['brand']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      inStock: json['inStock'] is bool ? json['inStock'] : true,
      images:
          (json['images'] as List<dynamic>?)?.map((img) {
            final map = img as Map<String, dynamic>;
            return {
              'color': map['color']?.toString() ?? '',
              'colorCode': map['colorCode']?.toString() ?? '',
              'image': map['image']?.toString() ?? '',
            };
          }).toList() ??
          [],
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((review) => review.toString())
              .toList() ??
          [],
    );
  }
}
