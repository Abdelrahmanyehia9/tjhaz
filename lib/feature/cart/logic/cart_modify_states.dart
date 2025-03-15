import 'package:equatable/equatable.dart';

abstract class CartModifyStates extends Equatable{
  const CartModifyStates();

  @override
  List<Object> get props => [];
}


class CartModifyStateInitial extends CartModifyStates{
  const CartModifyStateInitial() ;

}

class AddOrRemoveItemsToCartSuccess extends CartModifyStates{
  final String successMsg ;
  const AddOrRemoveItemsToCartSuccess(this.successMsg) ;
}
class AddOrRemoveItemsToCartFailure extends CartModifyStates{
  final String failureMsg ;
  const AddOrRemoveItemsToCartFailure(this.failureMsg) ;
}


class UpdateQuantityLoading extends CartModifyStates{
  const UpdateQuantityLoading() ;
}
class UpdateQuantitySuccess extends CartModifyStates{
  const UpdateQuantitySuccess() ;
}
class UpdateQuantityFailure extends CartModifyStates{
  final String errorMsg ;
  const UpdateQuantityFailure(this.errorMsg) ;
  @override
  List<Object> get props => [errorMsg];
}
