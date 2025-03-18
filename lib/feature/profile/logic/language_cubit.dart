import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import '../../../core/database/local/shared_prefrences_constants.dart';
import '../../../core/database/local/shared_prefrences_helper.dart';

class LanguageCubit extends Cubit<bool>{
LanguageCubit():super(true) ;


  Future<void> toggleLanguage( String lang , )async {
    await SharedPrefHelper.setString(SharedPrefConstants.currentLanguage, lang);
  }

  void getLanguage(){
    String curLang = SharedPrefHelper.getString(SharedPrefConstants.currentLanguage) ?? "ar";
    safeEmit(curLang == "ar" ? true : false);
  }


}