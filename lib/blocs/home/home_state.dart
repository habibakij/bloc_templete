part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class ItemLoading extends HomeState {}

class ItemLoaded extends HomeState {
  final List<ItemListModel> listItem;

  ItemLoaded({required this.listItem});
}

class ItemError extends HomeState {
  final String message;
  ItemError(this.message);
}
