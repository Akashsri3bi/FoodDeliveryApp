import 'package:flutter/material.dart ';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/bloc/basket/basket_bloc.dart';
import 'package:food/models/delivery_time_model.dart';

class DeliveryTimeScreen extends StatelessWidget {
  static const String routeName = "/delivery";

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => DeliveryTimeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('DeliveryTime'),
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
                onPressed: () {},
                child: const Text('Apply'),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Choose a Date',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Delivery is Today'),
                      duration: Duration(seconds: 2),
                    ));
                  },
                  child: const Text('Today'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Delivery is Tommorow'),
                      duration: Duration(seconds: 2),
                    ));
                  },
                  child: const Text('Tommorow'),
                ),
              ],
            ),
          ),
          Text(
            'Choose the Time',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 2.5),
                  itemCount: DeliveryTime.deliveryTimes.length,
                  itemBuilder: (context, index) {
                    return BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        return Card(
                          child: TextButton(
                            onPressed: () {
                              context.read<BasketBloc>().add(SelectDeliveryTime(
                                  DeliveryTime.deliveryTimes[index]));
                            },
                            child: Text(
                              DeliveryTime.deliveryTimes[index].value,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          )
        ]),
      ),
    );
  }
}
