import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_template/data/model/response/product_details_model.dart';
import 'package:flutter_bloc_template/data/repositories/product_repository.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final ProductRepository repository;
  DetailsBloc(this.repository) : super(ProductDetailsInit()) {
    on<ProductDetailsInitEvent>(onFetchDetailsData);
  }

  FutureOr<void> onFetchDetailsData(ProductDetailsInitEvent event, Emitter<DetailsState> emit) async {
    emit(const ProductDetailsLoadingState());
    try {
      final product = await repository.getProductById(event.productID ?? 0);
      emit(ProductDetailLoadedState(product ?? ProductDetailsModel()));
    } catch (e) {
      emit(ProductDetailsErrorState(e.toString()));
    }
  }
}
