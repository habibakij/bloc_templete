import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_template/data/model/response/product_model.dart';
import 'package:flutter_bloc_template/data/repositories/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository repository;
  List<ProductModel> productList = [];
  List<ProductModel> categoryList = [];

  HomeBloc(this.repository) : super(const ProductInitialState()) {
    on<DataFetchingEvent>(_onFetchProducts);
    on<FilterEvent>(_onCategoryWiseFiltering);
    on<FilterRemoveEvent>(_onFilterRemove);
  }

  /// get product list
  Future<void> _onFetchProducts(DataFetchingEvent event, Emitter<HomeState> emit) async {
    emit(const ProductLoadingState());
    try {
      final products = await repository.getProducts() ?? [];
      final List<ProductModel> categoryList = [];
      final Set<String> categorySet = {};
      for (final product in products) {
        if (product.category != null && categorySet.add(product.category ?? '')) {
          categoryList.add(product);
        }
      }
      repository.cartClear();
      emit(ProductLoadedState(products, categoryList));
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  /// category wise filtering
  void _onCategoryWiseFiltering(FilterEvent event, Emitter<HomeState> emit) {
    List<ProductModel> filteredProductList = [];
    String category = event.selectedCategory;
    filteredProductList = productList.where((e) => e.category == category).toList();
    emit(ProductFilterState(filteredProductList, event.selectedCategory));
  }

  /// remove filtering
  void _onFilterRemove(FilterRemoveEvent event, Emitter<HomeState> emit) {
    emit(ProductLoadedState(productList, categoryList));
  }
}
