import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/styles/card_sizes.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/cards/square_card.dart';
import 'package:tjhaz/core/widgets/cards/trip_card.dart';
import 'package:tjhaz/core/widgets/empty_list.dart';
import 'package:tjhaz/core/widgets/error_widget.dart';
import 'package:tjhaz/feature/categories/data/model/cateory_model.dart';
import 'package:tjhaz/feature/categories/view/widget/rectangular_categories.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainment_cubit.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainments_states.dart';
import 'package:tjhaz/core/widgets/global_app_bar.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../categories/view/widget/circular_categories.dart';
import '../widget/entertainment_grid_loading.dart';

class EntertainmentScreen extends StatefulWidget {

  final String catID;
  final List<CategoryModel>? categories  ;
  final String name  ;
  const EntertainmentScreen({super.key , required this.catID ,  this.categories ,required this.name });

  @override
  State<EntertainmentScreen> createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  late int activeIndex ;
  Size cardSize = CardSizes.tripCard ;
  @override
  void initState() {
    context.read<EntertainmentCubit>().getEntertainmentsByCatID(widget.catID) ;
    activeIndex = widget.categories != null ? widget.categories!.map((category)=>category.id).toList().indexOf(widget.catID) : 0 ;
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
                AppHeadline(tittle: widget.name),
                widget.categories==null?SizedBox(): SizedBox(
                  height: 110.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>  InkWell(
                      onTap: ()async{
                        await searchItemsByID(context, widget.categories![index].id) ;
                        setState(() {
                          activeIndex = index ;
                        });
                      },
                      child: widget.categories!.first.image == null ? CircularCategory(
                        isActive: activeIndex == index,
                        name: widget.categories![index].title,
                      ) : RectangularCategory(isActive: activeIndex == index,
                        name: widget.categories![index].title, img: widget.categories![index].image! , ),
                    ),
                    separatorBuilder: (context, state) => horizontalSpace(16),
                    itemCount: widget.categories!.length,
                  ),
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
                      ) : EmptyList(title: widget.categories?[activeIndex].title.tr()??widget.name) ;
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
    context.loaderOverlay.show() ;
    await context.read<EntertainmentCubit>().getEntertainmentsByCatID(id) ;
    if(context.mounted){
      context.loaderOverlay.hide() ;
    }
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
