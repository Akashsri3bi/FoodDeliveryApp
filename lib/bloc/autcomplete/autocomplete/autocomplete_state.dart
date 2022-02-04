part of 'autocomplete_bloc.dart';

abstract class AutocompleteState extends Equatable {
  const AutocompleteState();

  @override
  List<Object> get props => [];
}

class AutocompleteLoading extends AutocompleteState {}

class AutocompleteLoaded extends AutocompleteState {
  final List<PlaceAutoComplete> autoComplete;

  const AutocompleteLoaded({required this.autoComplete});

  @override
  List<Object> get props => [autoComplete];
}

class AutocompleteError extends AutocompleteState {}
