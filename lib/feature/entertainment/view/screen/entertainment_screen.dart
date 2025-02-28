import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/card_sizes.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/cards/square_card.dart';
import 'package:tjhaz/core/widgets/cards/trip_card.dart';
import 'package:tjhaz/core/widgets/empty_list.dart';
import 'package:tjhaz/core/widgets/error_widget.dart';
import 'package:tjhaz/feature/categories/data/model/cateory_model.dart';
import 'package:tjhaz/feature/categories/logic/categories_cubit.dart';
import 'package:tjhaz/feature/categories/logic/categories_states.dart';
import 'package:tjhaz/feature/categories/view/widget/rectangular_categories.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainment_cubit.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainments_states.dart';
import 'package:tjhaz/core/widgets/global_app_bar.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../categories/view/widget/circular_categories.dart';
import '../widget/entertainment_loading.dart';

class EntertainmentScreen extends StatefulWidget {
  final Map<String , String> parentCategory ;
  final int? activeCategory ;
  const EntertainmentScreen({super.key ,required this.parentCategory ,this.activeCategory });

  @override
  State<EntertainmentScreen> createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  late  int activeIndex   ;
  late String title  ;
  late Size cardSize = CardSizes.tripCard ;
  @override
  void initState() {
    title = widget.parentCategory['title']! ;
    activeIndex = widget.activeCategory ??  0  ;
    context.read<CategoriesCubit>().getCategoriesByParentId(widget.parentCategory["id"]!) ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), // Smooth scrolling
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalAppBar(),
                AppHeadline(tittle: title),
              BlocConsumer<CategoriesCubit  , CategoriesStates>(
                  builder: (context  , state){

                     if (state is CategoriesStateSuccess){
                       List<CategoryModel> categories = state.categories ;

                         return categories.isNotEmpty ? SizedBox(
                           height: 110.h,
                           child: ListView.separated(
                             scrollDirection: Axis.horizontal,
                             itemBuilder: (context, index) =>  InkWell(
                               onTap: ()async{
                                 setState(() {
                                   activeIndex = index ;
                                 });
                                 await searchItemsByID(context, categories[index].id) ;

                               },
                               child: categories.first.image == null ? CircularCategory(
                                 isActive: activeIndex == index,
                                 name: categories[index].title,
                               ) : RectangularCategory(isActive: activeIndex == index,
                                 name: categories[index].title, img: categories[index].image! , ),
                             ),
                             separatorBuilder: (context, state) => horizontalSpace(16),
                             itemCount: categories.length,
                           ),
                         ) : SizedBox() ;


                     }
                     else if (state is CategoriesStateLoading){
                     return EntertainmentCategoriesLoading() ;
                     }
                     else{
                       return SizedBox() ;
                     }
                  },
                listener: (context , state){
                    if(state is CategoriesStateSuccess){
                       context.read<EntertainmentCubit>().getEntertainmentsByCatID(state.categories[activeIndex].id) ;
                    }
                },
                )  ,
                verticalSpace(16),
                BlocBuilder<EntertainmentCubit  , EntertainmentsStates>(
                  builder : (context , state){
                    if (state is EntertainmentItemsSuccess){
                      return state.items.isNotEmpty ? GridView.builder(
                        shrinkWrap: true, // Makes GridView take only needed space
                        physics: const NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                        itemCount: state.items.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio:cardSize.width / cardSize.height,
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                        ),
                        itemBuilder: (context, index) =>  computeGridSize(state.items[index]),
                      ) : EmptyList(title: title.tr()) ;
                    }else if (state is EntertainmentItemsFailure){
                      return AppErrorWidget(error: state.errorMsg,) ;
                    }else{
                      return EntertainmentGridLoading() ;
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> searchItemsByID(BuildContext context , String id)async{
    await context.read<EntertainmentCubit>().getEntertainmentsByCatID(id) ;

  }
  Widget computeGridSize(EntertainmentDetailsModel model){
    if(model.facilities != null){
      cardSize = CardSizes.tripCard ;
      return TripCardItem(model: model,);
    }else{
      cardSize = CardSizes.squareCard ;
      return SquareCard(model: model,) ;
    }




  }
}
