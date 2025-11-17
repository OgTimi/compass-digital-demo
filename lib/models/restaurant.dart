class Restaurant {
  final String name;
  final String imageUrl;
  final double rating;
  final String address;
  final String price;
  final bool isClosed;

  Restaurant({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.address,
    required this.price,
    required this.isClosed,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      imageUrl: json['image_url'],
      rating: (json['rating'] as num).toDouble(),
      address: (json['location']['display_address'] as List<dynamic>).join(
        ', ',
      ),
      price: json['price'] ?? '',
      isClosed: json['is_closed'] ?? true,
    );
  }
}
