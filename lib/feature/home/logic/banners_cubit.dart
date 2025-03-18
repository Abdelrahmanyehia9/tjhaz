import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/home/data/repository/home_repository.dart';
import 'package:tjhaz/feature/home/logic/banners_states.dart';

class BannerCubit extends Cubit<BannersStates>{

  final HomeRepository homeRepository ;

  BannerCubit(this.homeRepository) : super(BannerStateInitial()) ;
    Future<void> getBanners() async{
      final results = await homeRepository.getAllBanners() ;
      results.fold((banners) {
        safeEmit(BannersStatesSuccess(banners));
      }, (error) {
        safeEmit(BannerStatesFailure());
      });
    }


  }


