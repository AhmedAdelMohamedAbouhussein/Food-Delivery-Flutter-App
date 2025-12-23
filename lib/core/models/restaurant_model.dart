class RestaurantModel {
  final String id;
  final String title;
  final String image;
  final String rating;
  final String reviews;
  final String distance;
  final String time;
  final String category; // 'fastest' or 'recommended'

  RestaurantModel({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.time,
    required this.category,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      rating: json['rating']?.toString() ?? '0.0',
      reviews: json['reviews']?.toString() ?? '0',
      distance: json['distance'] ?? '',
      time: json['time'] ?? '',
      category: json['category'] ?? '',
    );
  }
}