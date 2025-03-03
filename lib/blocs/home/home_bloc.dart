import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_template/data/model/home_screen/item_list_model.dart';
import 'package:flutter_bloc_template/data/repositories/home_screen_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    final HomeScreenRepository repository = HomeScreenRepository();
    on<HomeEvent>((event, emit) async {
      if (event is HomeEventInitial) {
        emit(ItemLoading());
        try {
          final items = await repository.fetchItems();
          log("check_date: ${items.length}");
          emit(ItemLoaded(listItem: items));
        } catch (e) {
          emit(ItemError(e.toString()));
        }
      }
    });
  }
}
