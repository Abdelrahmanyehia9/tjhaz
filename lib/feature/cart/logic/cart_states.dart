import 'package:equatable/equatable.dart';

abstract class CartStates extends Equatable {
  const CartStates();

  @override
  List<Object> get props => [];
}


class CartStatesInitial extends CartStates {
  const CartStatesInitial();
}
class CartStatesLoading extends CartStates {
  const CartStatesLoading();
}
class CartStatesSuccess extends CartStates {
  const CartStatesSuccess();
}
class CartStatesFailure extends CartStates {
  final String errorMsg;
  const CartStatesFailure(this.errorMsg);
}
