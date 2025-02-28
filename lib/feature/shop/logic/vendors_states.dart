import 'package:equatable/equatable.dart';
import 'package:tjhaz/feature/shop/data/model/vendor_model.dart';

abstract class VendorsStates extends Equatable{
  const VendorsStates() ;
  @override
  List<Object?> get props => [];
}
class VendorsStatesInitial extends VendorsStates{}
class VendorsStatesLoading extends VendorsStates{}
class VendorsStatesFailure extends VendorsStates{
  final String error ;
  const VendorsStatesFailure(this.error)  ;
  @override
  List<Object?> get props => [error];
}
class VendorsStatesSuccess extends VendorsStates{
  final List<VendorModel> vendors;
 const  VendorsStatesSuccess(this.vendors);
  @override
  List<Object?> get props => [vendors];
}