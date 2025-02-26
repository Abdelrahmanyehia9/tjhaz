import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/home/data/repository/home_repository.dart';
import 'package:tjhaz/feature/home/logic/banners_states.dart';

class BannerCubit extends Cubit<BannersStates>{

  final HomeRepository homeRepository ;

  BannerCubit(this.homeRepository) : super(BannerStateInitial()) ;
    Future<void> getBanners() async{
      final results = await homeRepository.getAllBanners() ;
      results.fold((banners) {
        emit(BannersStatesSuccess(banners));
      }, (error) {
        emit(BannerStatesFailure());
      });
    }


  }


