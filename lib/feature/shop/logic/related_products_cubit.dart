import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/shop/data/model/product_mode.dart';
import 'package:tjhaz/feature/shop/data/repository/shop_repository.dart';
import 'package:tjhaz/feature/shop/logic/related_products_states.dart';

class RelatedProductsCubit extends Cubit<RelatedProductsStates>{
  final ShopRepository shopRepository ;
   RelatedProductsCubit(this.shopRepository):super(RelatedProductsStatesInitial()) ;




  Future<void>getRelatedProducts(ProductModel product)async{
    safeEmit(RelatedProductsStatesLoading()) ;
    final results = await shopRepository.getRelatedProducts(product) ;
    results.fold((products){
      safeEmit(RelatedProductsStatesSuccess(products)) ;
    }, (error){
      safeEmit(RelatedProductsStatesFailure(error));
    }) ;




  }


}