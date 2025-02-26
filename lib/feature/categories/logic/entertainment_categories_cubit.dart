import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/categories/data/repository/categories_repository.dart';
import 'package:tjhaz/feature/categories/logic/entertainment_categories_states.dart';

class EntertainmentCategoriesCubit extends Cubit<EntertainmentCategoriesStates>{
  final CategoryRepository repository ;
  EntertainmentCategoriesCubit(this.repository ,):super(EntertainmentCategoriesStatesInitial()) ;

  Future<void> getEntertainmentsSubCategoryByParentID(String pID) async {
    emit(EntertainmentCategoriesStatesLoading());
    final results = await repository.getSubCategoriesByParentID(pID) ;
    results.fold((items) {
      emit(EntertainmentCategoriesStatesSuccess(items));
    }, (error) {
      emit(EntertainmentCategoriesStatesFailure(error));
    }) ;
  }






}