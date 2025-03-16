import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/cart/data/model/cart_model.dart';
import 'package:tjhaz/feature/cart/data/repository/cart_repository.dart';
import 'cart_modify_states.dart';

class CartModifyCubit extends Cubit<CartModifyStates> {

  final CartRepository cartRepository;
  Map<String , int>quantityMap = {} ;

  CartModifyCubit(this.cartRepository) : super(CartModifyStateInitial());

  Future<void> getItemQuantity({required String itemID})async{
   final result = await cartRepository.getQuantityOfItemInCart(itemID) ;
   result.fold((quantity){
     quantityMap[itemID] = quantity ;
   }, (_)=>{}) ;
  }
  Future<void> addItemToCart({required CartModel cartModel }) async {
    final result = await cartRepository.addItemToCart(cartModel: cartModel) ;

    result.fold((_) {
      quantityMap[cartModel.itemID] = 1 ;
      safeEmit(AddOrRemoveItemsToCartSuccess("Item Added SuccessFully"));
    }, (error)=>safeEmit(AddOrRemoveItemsToCartFailure(error))) ;
  }
  Future<void>updateItemQuantity(bool isIncrement , String itemID)async{
    emit(UpdateQuantityLoading()) ;
    final result = await cartRepository.quantityUpdate( isIncrement ,  itemID) ;
     safeEmit(UpdateQuantitySuccess()) ;
    if(isIncrement){
      quantityMap[itemID] = quantityMap[itemID]! + 1 ;
    }else{
      quantityMap[itemID] == 1 ? removeItemFromCart(itemID: itemID) :quantityMap[itemID] = quantityMap[itemID]! - 1 ;
    }
    result.fold((_){}, (error){
      safeEmit(UpdateQuantityFailure(error)) ;
    }) ;
  }
  Future<void>removeItemFromCart({required String itemID})async{
    final result = await cartRepository.removeItemFromCart(itemID: itemID) ;
    result.fold((_) {
      safeEmit(AddOrRemoveItemsToCartSuccess("Item Removed SuccessFully"));
      quantityMap[itemID] = 0 ;
    }, (error)=>safeEmit(AddOrRemoveItemsToCartFailure(error))) ;
  }


}