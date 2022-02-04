import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food/models/places_autocomplete_model.dart';
import 'package:food/repositories/places/places_repository.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? _placestreamSubscription;
  AutocompleteBloc({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(AutocompleteLoading());
  @override
  Stream<AutocompleteState> mapEventToState(AutocompleteEvent event) async* {
    if (event is LoadAutocomplete) {
      yield* _mapLoadAutoCompleteToState(event);
    }
  }

  Stream<AutocompleteState> _mapLoadAutoCompleteToState(
      LoadAutocomplete event) async* {
    _placestreamSubscription?.cancel();
    final List<PlaceAutoComplete> autoComplete =
        await _placesRepository.getAutoComplete(event.searchInput);
    yield AutocompleteLoaded(autoComplete: autoComplete);
  }
}
