import 'package:flutter/material.dart ';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/bloc/filters/filters_bloc.dart';
import 'package:food/models/restaurant_model.dart';

class FilterScreen extends StatelessWidget {
  static const String routeName = "/filter";

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => FilterScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Filter'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<FiltersBloc, FiltersState>(
                builder: (context, state) {
                  if (state is FiltersLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FiltersLoaded) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                      ),
                      onPressed: () {
                        var categories = state.filters.categoryFilters
                            .where((filter) => filter.value)
                            .map((filter) => filter.category.name)
                            .toList();

                        var prices = state.filters.priceFilter
                            .where((filter) => filter.value)
                            .map((filter) => filter.price.price)
                            .toList();

                        List<Restaurant> restaurants = Restaurant.restaurants
                            .where((restaurant) => categories.any((category) =>
                                restaurant.tags.contains(category)))
                            .where((restaurant) => prices.any((price) =>
                                restaurant.priceCategory.contains(price)))
                            .toList();

                        Navigator.pushNamed(context, '/restaurantlisting',
                            arguments: restaurants);
                      },
                      child: const Text('Apply'),
                    );
                  } else {
                    return const Text('Something went wrong');
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            const CustomPriceFilter(),
            Text(
              'Category',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            const CustomCategoryFilter(),
          ],
        ),
      ),
    );
  }
}

class CustomCategoryFilter extends StatelessWidget {
  const CustomCategoryFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      builder: (context, state) {
        if (state is FiltersLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is FiltersLoaded) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.filters.categoryFilters.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    children: [
                      Text(
                        state.filters.categoryFilters[index].category.name,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 25,
                        child: Checkbox(
                          value: state.filters.categoryFilters[index].value,
                          onChanged: (bool? newValue) {
                            context.read<FiltersBloc>().add(
                                    CategoryFilterUpdated(
                                        categoryFilter: state
                                            .filters.categoryFilters[index]
                                            .copyWith(
                                  value: !state
                                      .filters.categoryFilters[index].value,
                                )));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              });
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}

class CustomPriceFilter extends StatelessWidget {
  const CustomPriceFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      builder: (context, state) {
        if (state is FiltersLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FiltersLoaded) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: state.filters.priceFilter
                  .asMap()
                  .entries
                  .map(
                    (price) => InkWell(
                      onTap: () {
                        context.read<FiltersBloc>().add(PriceFilterUpdated(
                                priceFilter: state
                                    .filters.priceFilter[price.key]
                                    .copyWith(
                              value:
                                  !state.filters.priceFilter[price.key].value,
                            )));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        decoration: BoxDecoration(
                          color: state.filters.priceFilter[price.key].value
                              ? Theme.of(context).primaryColor.withAlpha(100)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          state.filters.priceFilter[price.key].price.price,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                  )
                  .toList());
        } else {
          return const Text('SomeThing went Wrong');
        }
      },
    );
  }
}
