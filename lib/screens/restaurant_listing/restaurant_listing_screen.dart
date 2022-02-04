import 'package:flutter/material.dart ';
import 'package:food/models/restaurant_model.dart';
import 'package:food/screens/homeScreen/homescreen.dart';

class RestaurantListingScreen extends StatelessWidget {
  final List<Restaurant> restaurants;
  static const String routeName = "/restaurantlisting";

  const RestaurantListingScreen({required this.restaurants});

  static Route route({required List<Restaurant> restaurants}) {
    return MaterialPageRoute(
      builder: (context) => RestaurantListingScreen(restaurants: restaurants),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Restaurants'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return RestaurantCard(restaurant: restaurants[index]);
            }),
      ),
    );
  }
}
