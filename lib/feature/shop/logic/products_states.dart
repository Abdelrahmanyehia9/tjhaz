import 'package:tjhaz/feature/shop/data/model/product_mode.dart';

abstract class ProductsStates{
  const ProductsStates() ;
}
class ProductsStatesInitial extends ProductsStates{}
class ProductsStatesLoading extends ProductsStates{}
class ProductsStatesFailure extends ProductsStates{
  final String error  ;
  const ProductsStatesFailure(this.error) ;
}
class ProductsStatesSuccess extends ProductsStates{
  final List<ProductModel> products  ;
  const ProductsStatesSuccess(this.products) ;
}