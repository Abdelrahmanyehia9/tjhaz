import 'package:equatable/equatable.dart';

import '../data/models/banner_model.dart';

abstract class BannersStates extends Equatable{
  const BannersStates();
  @override
  List<Object> get props => [];
}

class BannerStateInitial extends BannersStates{}
class BannersStatesSuccess extends BannersStates{
  final List<BannerModel> banners ;
  const BannersStatesSuccess(this.banners);
  @override
  List<Object> get props => [banners];
}
class BannerStatesFailure extends BannersStates{}