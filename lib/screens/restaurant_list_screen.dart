import 'package:compass_digital_demo/models/restaurant.dart';
import 'package:compass_digital_demo/screens/widgets/empty_state.dart';
import 'package:compass_digital_demo/screens/widgets/restaurant_list_item.dart';
import 'package:compass_digital_demo/services/yelp_service.dart';
import 'package:flutter/material.dart';

import 'widgets/restaurant_list_item_shimmer.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search restaurants...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
                onSubmitted: (value) {
                  setState(() {
                    _restaurantFuture = yelpService.fetchRestaurants(
                      value.isEmpty ? 'Toronto' : value,
                    );
                  });
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: FutureBuilder<List<Restaurant>>(
                future: _restaurantFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) =>
                          const RestaurantListItemShimmer(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return EmptyState(
                      message:
                          'No restaurants found for this location.\nTry another search.',
                    );
                  }

                  final restaurants = snapshot.data!;
                  return ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return RestaurantListItem(restaurant: restaurant);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
