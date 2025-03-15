import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/cart/data/repository/cart_repository.dart';
import 'package:tjhaz/feature/cart/logic/cart_states.dart';
import '../data/model/cart_model.dart';

class CartCubit extends Cubit<CartStates>{
  final CartRepository cartRepository ;
  List<CartModel> cartItems = [] ;
  CartCubit(this.cartRepository) : super(CartStatesInitial()) ;



  Future<void> getCartItems()async{
    safeEmit(CartStatesLoading()) ;
    final result = await cartRepository.getCartItems() ;
    result.fold((items){
      cartItems = items ;
      safeEmit(CartStatesSuccess()) ;
    }, (error)=>safeEmit(CartStatesFailure(error))) ;

  }




}