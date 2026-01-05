part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class ProductInitialState extends HomeState {
  const ProductInitialState();
}

class ProductLoadingState extends HomeState {
  const ProductLoadingState();
}

class ProductLoadedState extends HomeState {
  final List<ProductModel> products;
  final List<ProductModel> categoryList;

  const ProductLoadedState(this.products, this.categoryList);
  @override
  List<Object?> get props => [products, categoryList];
}

class ProductFilterState extends HomeState {
  final List<ProductModel> filteringList;
  final String? selectedCategory;
  const ProductFilterState(this.filteringList, this.selectedCategory);

  @override
  List<Object?> get props => [filteringList, selectedCategory];
}

class ProductErrorState extends HomeState {
  final String message;
  const ProductErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
