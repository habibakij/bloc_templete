part of 'details_bloc.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class ItemLoading extends DetailsState {}

class ItemLoaded extends DetailsState {
  final ItemDetailsModel itemDetails;
  ItemLoaded({required this.itemDetails});
}

class ItemError extends DetailsState {
  final String message;
  ItemError(this.message);
}
