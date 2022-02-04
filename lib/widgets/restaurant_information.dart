import 'package:flutter/material.dart';
import 'package:food/models/restaurant_model.dart';
import 'package:food/widgets/restaurant_tags.dart';

class RestaurantInformation extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantInformation({Key? key, required this.restaurant})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          RestaurantTags(restaurant: restaurant),
          const SizedBox(
            height: 5,
          ),
          Text('${restaurant.distance} km away - \$${restaurant.deliveryFee} ',
              style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(
            height: 10,
          ),
          Text('Restaurant Information',
              style: Theme.of(context).textTheme.headline5),
          const SizedBox(
            height: 5,
          ),
          Text(
              'Lorem ipsum color sit ammet , adipisicing elit , sedend the huraro',
              style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    );
  }
}
