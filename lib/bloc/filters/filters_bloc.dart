import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food/models/category_filter_model.dart';
import 'package:food/models/filter_model.dart';
import 'package:food/models/price_filter_model.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersLoading());

  @override
  Stream<FiltersState> mapEventToState(
    FiltersEvent event,
  ) async* {
    if (event is FilterLoad) {
      yield* _mapFilterLoadToState();
    }
    if (event is CategoryFilterUpdated) {
      yield* _mapCategoryFilterUpdatedToState(event, state);
    }

    if (event is PriceFilterUpdated) {
      yield* _mapPriceFilterUpdatedToState(event, state);
    }
  }

  Stream<FiltersState> _mapFilterLoadToState() async* {
    yield FiltersLoaded(
      filters: Filter(
          categoryFilters: CategoryFilter.filters,
          priceFilter: PriceFilter.filters),
    );
  }

  Stream<FiltersState> _mapCategoryFilterUpdatedToState(
      CategoryFilterUpdated event, FiltersState state) async* {
    if (state is FiltersLoaded) {
      final List<CategoryFilter> upatedCategoryfilters =
          state.filters.categoryFilters.map((categoryFilter) {
        return categoryFilter.id == event.categoryFilter.id
            ? event.categoryFilter
            : categoryFilter;
      }).toList();

      yield FiltersLoaded(
          filters: Filter(
        categoryFilters: upatedCategoryfilters,
        priceFilter: state.filters.priceFilter,
      ));
    }
  }

  Stream<FiltersState> _mapPriceFilterUpdatedToState(
      PriceFilterUpdated event, FiltersState state) async* {
    if (state is FiltersLoaded) {
      final List<PriceFilter> upatedPricefilters =
          state.filters.priceFilter.map((priceFilters) {
        return priceFilters.id == event.priceFilter.id
            ? event.priceFilter
            : priceFilters;
      }).toList();

      yield FiltersLoaded(
          filters: Filter(
        priceFilter: upatedPricefilters,
        categoryFilters: state.filters.categoryFilters,
      ));
    }
  }
}
