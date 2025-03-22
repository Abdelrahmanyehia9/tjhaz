import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/cart/data/repository/cart_repository.dart';
import 'package:tjhaz/feature/cart/logic/cart_states.dart';
import '../data/model/cart_model.dart';

class CartCubit extends Cubit<CartStates>{
  final CartRepository cartRepository ;
  List<CartModel> cartItems = [] ;
  CartCubit(this.cartRepository) : super(const CartStatesInitial()) ;



  Future<void> getCartItems()async{
    safeEmit(const CartStatesLoading()) ;
    final result = await cartRepository.getCartItems() ;
    result.fold((items){
      cartItems = items ;
      safeEmit(const CartStatesSuccess()) ;
    }, (error)=>safeEmit(CartStatesFailure(error))) ;

  }
  Future<void> updateItemQuantity(bool isIncrement , String itemID)async{
    emit(UpdateQuantityLoading(itemID)) ;
    final result = await cartRepository.quantityUpdate( isIncrement ,  itemID ) ;
     safeEmit(const UpdateQuantitySuccess());
    if(isIncrement){
      cartItems.firstWhere((element) => element.itemID == itemID).itemQuantity = cartItems.firstWhere((element) => element.itemID == itemID).itemQuantity + 1 ;
    }else{ cartItems.firstWhere((element) => element.itemID == itemID).itemQuantity = cartItems.firstWhere((element) => element.itemID == itemID).itemQuantity - 1 ;}
    result.fold((_){}, (error){
      safeEmit(UpdateQuantityFailure(error)) ;
    }) ;
  }
  Future<void>removeItemFromCart({required String itemID})async{
    safeEmit(UpdateQuantityLoading(itemID)) ;
    final result = await cartRepository.removeItemFromCart(itemID: itemID) ;
    result.fold((_){
      cartItems.removeWhere((element) => element.itemID == itemID) ;
      safeEmit(const UpdateQuantitySuccess()) ;
    }, (error){
      safeEmit(UpdateQuantityFailure(error)) ;
    }) ;
    getCartItems() ; 
  }
  Future<void>addItemToCart({required CartModel model})async{
    safeEmit(UpdateQuantityLoading(model.itemID)) ;
    final result = await cartRepository.addItemToCart(cartModel: model) ;
    result.fold((_){
      cartItems.add(model) ;
      safeEmit(const UpdateQuantitySuccess()) ;
    }, (error){
      safeEmit(UpdateQuantityFailure(error)) ;
    }) ;
  }




}