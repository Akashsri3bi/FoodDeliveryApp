import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/bloc/basket/basket_bloc.dart';

class EditBasketScreen extends StatelessWidget {
  static const String routeName = "/edit-basket";

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => EditBasketScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Edit Basket'),
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
                  Navigator.pop(context);
                },
                child: const Text('Done'),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Items',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              BlocBuilder<BasketBloc, BasketState>(
                builder: (context, state) {
                  if (state is BasketLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BasketLoaded) {
                    return state.basket.items.isEmpty
                        ? Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'No Items in the Basket',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.basket
                                .itemQuantity(state.basket.items)
                                .keys
                                .length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Row(
                                  children: [
                                    Text(
                                      '${state.basket.itemQuantity(state.basket.items).entries.elementAt(index).value}x',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${state.basket.itemQuantity(state.basket.items).keys.elementAt(index).name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () {
                                        context.read<BasketBloc>().add(
                                            RemoveAllItem(state.basket
                                                .itemQuantity(
                                                    state.basket.items)
                                                .keys
                                                .elementAt(index)));
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () {
                                        context.read<BasketBloc>().add(
                                            RemoveItem(state.basket
                                                .itemQuantity(
                                                    state.basket.items)
                                                .keys
                                                .elementAt(index)));
                                      },
                                      icon: const Icon(Icons.remove_circle),
                                    ),
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () {
                                        context.read<BasketBloc>().add(AddItem(
                                            state.basket
                                                .itemQuantity(
                                                    state.basket.items)
                                                .keys
                                                .elementAt(index)));
                                      },
                                      icon: const Icon(Icons.add_circle),
                                    ),
                                  ],
                                ),
                              );
                            });
                  } else {
                    return const Text('SomeThing Went Wrong');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
