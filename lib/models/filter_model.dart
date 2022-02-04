import 'package:equatable/equatable.dart';
import 'package:food/models/category_filter_model.dart';
import 'package:food/models/price_filter_model.dart';

class Filter extends Equatable {
  final List<CategoryFilter> categoryFilters;
  final List<PriceFilter> priceFilter;

  const Filter({
    this.categoryFilters = const <CategoryFilter>[],
    this.priceFilter = const <PriceFilter>[],
  });

  Filter copyWith({
    List<CategoryFilter>? categoryFilters,
    List<PriceFilter>? priceFilter,
  }) {
    return Filter(
        categoryFilters: categoryFilters ?? this.categoryFilters,
        priceFilter: priceFilter ?? this.priceFilter);
  }

  @override
  List<Object?> get props => [categoryFilters, priceFilter];
}
