import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/restaurant.dart';

class YelpService {
  static const String _baseUrl = 'https://api.yelp.com/v3/businesses';

  Future<List<Restaurant>> fetchRestaurants(String location) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search?term=restaurants&location=$location'),
      headers: {'Authorization': 'Bearer ${Configurations.yelpApiKey}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List businesses = data['businesses'];
      final restuarants = businesses
          .map((business) => Restaurant.fromJson(business))
          .toList();
      return restuarants;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
