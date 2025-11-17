import 'package:compass_digital_demo/models/restaurant.dart';
import 'package:compass_digital_demo/screens/widgets/restaurant_list_item.dart';
import 'package:compass_digital_demo/services/yelp_service.dart';
import 'package:flutter/material.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final YelpService yelpService = YelpService();
  late Future<List<Restaurant>> _restaurantFuture;

  @override
  void initState() {
    super.initState();
    _restaurantFuture = yelpService.fetchRestaurants('Toronto');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Restaurants')),
      body: FutureBuilder<List<Restaurant>>(
        future: _restaurantFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No restaurants found'));
          }

          final restaurants = snapshot.data!;
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return RestaurantListItem(restaurant: restaurant);
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: restaurant.imageUrl.isNotEmpty
                      ? Image.network(
                          restaurant.imageUrl,
                          width: 60,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.restaurant),
                  title: Text(restaurant.name),
                  subtitle: Text('${restaurant.address} ${restaurant.rating}'),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
