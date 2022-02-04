import 'package:flutter/material.dart';
import 'package:food/models/promo_model.dart';

class PromoBox extends StatelessWidget {
  final Promo promo;
  const PromoBox({required this.promo});

  //We will use custom Clipper widget to give different shapes and design to our promotion box.
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(right: 5.0),
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Theme.of(context).primaryColor,
            image: DecorationImage(
                image: NetworkImage(promo.imageUrl), fit: BoxFit.cover)),
      ),
      ClipPath(
        clipper: PromoCustomClipper(),
        child: Container(
          margin: const EdgeInsets.only(right: 5.0),
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 125),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promo.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  promo.description,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

class PromoCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(190, size.height);
    path.lineTo(225, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
