import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/shop/data/repository/shop_repository.dart';
import 'package:tjhaz/feature/shop/logic/vendors_states.dart';

class VendorCubit extends Cubit<VendorsStates>{
  final ShopRepository shopRepository ;
  VendorCubit(this.shopRepository):super(VendorsStatesInitial()) ;

  Future<void>getAllVendors()async{
    safeEmit(VendorsStatesLoading()) ;
    final results = await shopRepository.getAllVendors()  ;
    results.fold((vendors){
      safeEmit(VendorsStatesSuccess(vendors));
      }, (error){
      safeEmit(VendorsStatesFailure(error)) ;
    });

  }








}