import 'package:flutter/material.dart';
import 'package:food/models/restaurant_model.dart';
import 'package:food/screens/basket/basket_screen.dart';
import 'package:food/screens/chekout/checkout_screen.dart';
import 'package:food/screens/delivery_time/delivery_time_screen.dart';
import 'package:food/screens/edit_basket/edit_basket_screen.dart';
import 'package:food/screens/filter/filter_screen.dart';
import 'package:food/screens/homeScreen/homescreen.dart';
import 'package:food/screens/locations/location_screen.dart';
import 'package:food/screens/restaurant_details/restaurant_details_screen.dart';
import 'package:food/screens/restaurant_listing/restaurant_listing_screen.dart';
import 'package:food/screens/voucher/voucher_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    // ignore: avoid_print
    print("The Route is : ${settings.name}");

    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case LoactionScreen.routeName:
        return LoactionScreen.route();
      case EditBasketScreen.routeName:
        return EditBasketScreen.route();
      case BasketScreen.routeName:
        return BasketScreen.route();
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case DeliveryTimeScreen.routeName:
        return DeliveryTimeScreen.route();
      case FilterScreen.routeName:
        return FilterScreen.route();
      case RestaurantListingScreen.routeName:
        return RestaurantListingScreen.route(
            restaurants: settings.arguments as List<Restaurant>);
      case RestaurantDetailsScreen.routeName:
        return RestaurantDetailsScreen.route(
            restaurant: settings.arguments as Restaurant);
      case VoucherScreen.routeName:
        return VoucherScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('error'),
              ),
            ),
        settings: const RouteSettings(name: '/error'));
  }
}
