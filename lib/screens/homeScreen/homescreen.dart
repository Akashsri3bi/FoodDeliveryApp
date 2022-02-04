import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:food/config/theme.dart';
import 'package:food/models/category_model.dart';
import 'package:food/models/promo_model.dart';
import 'package:food/models/restaurant_model.dart';
import 'package:food/widgets/category_box.dart';
import 'package:food/widgets/food_search.dart';
import 'package:food/widgets/promo_box.dart';
import 'package:food/widgets/restaurant_tags.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/";

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                    itemCount: Category.categories.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CategoryBox(category: Category.categories[index]);
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 125,
                child: ListView.builder(
                    itemCount: Promo.promos.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return PromoBox(
                        promo: Promo.promos[index],
                      );
                    }),
              ),
            ),
            const FoodSearchBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Top Rated',
                    style: Theme.of(context).textTheme.headline4,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: Restaurant.restaurants.length,
                  itemBuilder: (context, index) {
                    return RestaurantCard(
                        restaurant: Restaurant.restaurants[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard({required this.restaurant});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/restaurantdetails',
            arguments: restaurant);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                      image: NetworkImage(restaurant.imageUrl),
                      fit: BoxFit.cover)),
            ),

            //Another Container on top of this to show delivery Time

            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${restaurant.deliveryTime} min',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 5,
                ),
                //Text('${restaurant.tags}' , style: ,),

                RestaurantTags(restaurant: restaurant),

                const SizedBox(
                  height: 5,
                ),
                Text(
                    '${restaurant.distance}Km - \$${restaurant.deliveryFee} delivery fee',
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with ObstructingPreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: theme().primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {},
        ),
        centerTitle: false,
        title: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CURRENT LOCATION',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white)),
                Text('Singapore, 1 Shenton Way',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              Navigator.pushNamed(context, '/location');
            },
          ),
        ]));
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
