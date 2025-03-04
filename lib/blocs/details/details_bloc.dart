import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_template/data/model/details_screen/item_details_model.dart';
import 'package:flutter_bloc_template/data/repositories/details_screen_repository.dart';
part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DetailsScreenRepository repository = DetailsScreenRepository();

  DetailsBloc() : super(DetailsInitial()) {
    on<DetailsEvent>((event, emit) async {
      if (event is DetailsEventInitial) {
        emit(ItemLoading());
        try {
          final itemDetails =
              await repository.fetchItemDetailsData(itemID: event.itemID);
          log("check_item_title: ${itemDetails.title}");
          emit(ItemLoaded(itemDetails: itemDetails));
        } catch (e) {
          emit(ItemError(e.toString()));
        }
      }
    });
  }
}
