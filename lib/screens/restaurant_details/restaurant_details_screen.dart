import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart ';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/bloc/basket/basket_bloc.dart';
import 'package:food/models/restaurant_model.dart';
import 'package:food/widgets/restaurant_information.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  static const String routeName = "/restaurantdetails";

  static Route route({required Restaurant restaurant}) {
    return MaterialPageRoute(
      builder: (context) => RestaurantDetailsScreen(
        restaurant: restaurant,
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  final Restaurant restaurant;
  const RestaurantDetailsScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    //Restaurant restaurant = Restaurant.restaurants[0];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/basket');
                },
                child: const Text('Basket'),
              )
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom:
                      Radius.elliptical(MediaQuery.of(context).size.width, 50),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(restaurant.imageUrl),
                ),
              ),
            ),
            RestaurantInformation(restaurant: restaurant),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: restaurant.tags.length,
                itemBuilder: (context, index) {
                  return _buildMenuItems(restaurant, context, index);
                })
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems(
      Restaurant restaurant, BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
          child: Text(
            restaurant.tags[index],
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ),
        Column(
          children: restaurant.menuItems
              .where((menuItem) => menuItem.category == restaurant.tags[index])
              .map(
                (menuItem) => Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(menuItem.name,
                            style: Theme.of(context).textTheme.headline5),
                        subtitle: Text(menuItem.description,
                            style: Theme.of(context).textTheme.bodyText1),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '\$${menuItem.price}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            BlocBuilder<BasketBloc, BasketState>(
                              builder: (context, state) {
                                return IconButton(
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<BasketBloc>()
                                        .add(AddItem(menuItem));
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 2,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
