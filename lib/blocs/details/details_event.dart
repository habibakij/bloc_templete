part of 'details_bloc.dart';

abstract class DetailsEvent {}

class DetailsEventInitial extends DetailsEvent {
  final int itemID;
  DetailsEventInitial({required this.itemID});
}
