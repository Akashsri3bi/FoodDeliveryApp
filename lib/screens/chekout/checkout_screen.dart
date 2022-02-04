import 'package:flutter/material.dart ';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = "/checkout";

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => CheckoutScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('LoactionScreen'),
          onPressed: () {
            Navigator.pushNamed(context, '/location');
          },
        ),
      ),
    );
  }
}
