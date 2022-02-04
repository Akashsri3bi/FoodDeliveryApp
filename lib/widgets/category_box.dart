import 'package:flutter/material.dart';
import 'package:food/models/category_model.dart';
import 'package:food/models/restaurant_model.dart';

class CategoryBox extends StatelessWidget {
  final Category category;

  const CategoryBox({required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Restaurant> restaurants = Restaurant.restaurants
        .where(
          (restaurant) => restaurant.tags.contains(category.name),
        )
        .toList();
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/restaurantlisting',
            arguments: restaurants);
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 5.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                child: category.image,
                height: 50,
                width: 60,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(category.name,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white,
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
