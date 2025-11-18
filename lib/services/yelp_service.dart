import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/restaurant.dart';

class YelpService {
  static const String _baseUrl = 'https://api.yelp.com/v3/businesses';

  Future<List<Restaurant>> fetchRestaurants(String location) async {
    try {
      List<Restaurant> restaurants = [];
      final response = await http.get(
        Uri.parse('$_baseUrl/search?term=restaurants&location=$location'),
        headers: {'Authorization': 'Bearer ${Configurations.yelpApiKey}'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List businesses = data['businesses'];
        restaurants = businesses
            .map((business) => Restaurant.fromJson(business))
            .toList();
      }
      return restaurants;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('Error fetching restaurants: $e');
        debugPrintStack(stackTrace: stackTrace);
      }
      throw Exception('Error fetching restaurants');
    }
  }
}
