import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/cart/data/model/cart_model.dart';
import 'package:tjhaz/feature/cart/data/repository/cart_repository.dart';
import 'package:tjhaz/feature/cart/logic/cart_states.dart';

class CartCubit extends Cubit<CartStates>{
  List<CartModel> items = []  ;

 final  CartRepository cartRepository ;
   CartCubit(this.cartRepository):super(CartStatesInitial()) ;

 Future<void>getMyCartItems()async{
   final res = await cartRepository.getAllItemsInCart() ;
res.fold((items){
  this.items =  items ;
}, (error){
  print(error) ;
}) ;



 }
}