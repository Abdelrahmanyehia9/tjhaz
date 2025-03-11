import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/shop/data/repository/shop_repository.dart';
import 'package:tjhaz/feature/shop/logic/products_states.dart';

class ProductsCubit extends Cubit<ProductsStates>{
  final ShopRepository shopRepository ;

  ProductsCubit(this.shopRepository):super(ProductsStatesInitial()) ;

Future<void>getAllProductByVendorID(vendorId)async{
 final results = await shopRepository.getAllProductsByVendorID(vendorId);
 results.fold((products){
   safeEmit(ProductsStatesSuccess(products)) ;
 }, (error){
   safeEmit(ProductsStatesFailure(error)) ;
 }) ;
}
}