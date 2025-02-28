import 'package:equatable/equatable.dart';
import 'package:tjhaz/feature/shop/data/model/product_mode.dart';

abstract class RelatedProductsStates extends Equatable{
  const RelatedProductsStates() ;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RelatedProductsStatesInitial extends RelatedProductsStates{
  const RelatedProductsStatesInitial() ;
}
class RelatedProductsStatesLoading extends RelatedProductsStates{
  const RelatedProductsStatesLoading() ;
}
class RelatedProductsStatesSuccess extends RelatedProductsStates{
  final List<ProductModel> products ;
  const RelatedProductsStatesSuccess(this.products) ;


  @override
  // TODO: implement props
  List<Object?> get props => [products];
}

class RelatedProductsStatesFailure extends RelatedProductsStates{
  final String error ;
  const RelatedProductsStatesFailure(this.error) ;

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}