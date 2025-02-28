import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/shop/data/repository/shop_repository.dart';
import 'package:tjhaz/feature/shop/logic/vendors_states.dart';

class VendorCubit extends Cubit<VendorsStates>{
  final ShopRepository shopRepository ;
  VendorCubit(this.shopRepository):super(VendorsStatesInitial()) ;

  Future<void>getAllVendors()async{
    emit(VendorsStatesLoading()) ;
    final results = await shopRepository.getAllVendors()  ;
    results.fold((vendors){
      emit(VendorsStatesSuccess(vendors));
      }, (error){
      emit(VendorsStatesFailure(error)) ;
    });

  }








}