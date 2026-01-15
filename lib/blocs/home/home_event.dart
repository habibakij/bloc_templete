part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class DataFetchingEvent extends HomeEvent {
  const DataFetchingEvent();
}

class FilterEvent extends HomeEvent {
  final String selectedCategory;
  const FilterEvent(this.selectedCategory);
}

class FilterRemoveEvent extends HomeEvent {
  const FilterRemoveEvent();
}
