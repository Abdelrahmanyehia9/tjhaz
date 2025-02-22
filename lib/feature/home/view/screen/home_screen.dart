import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/constants.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/styles/app_gradient.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/feature/home/logic/trips_cubit.dart';
import 'package:tjhaz/feature/home/logic/trips_states.dart';
import '../../../../core/utils/cached_network_img_helper.dart';
import '../../../../core/widgets/app_slider.dart';
import '../../data/models/home_model.dart';
import '../widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return  Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeAppBar() ,
                verticalSpace(18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(AppConstants.categories.length, (index)=> categoryItem(AppConstants.categories[index]["image"]!, AppConstants.categories[index]["title"]!)),
                ),
                verticalSpace(16),
                AppSlider(height: screenHeight(context)*.225,
                    imageList: ["https://i.pinimg.com/736x/17/7c/96/177c9667f8a87b10e3dd36fff6cd9e06.jpg","https://i.pinimg.com/736x/17/7c/96/177c9667f8a87b10e3dd36fff6cd9e06.jpg","https://i.pinimg.com/736x/17/7c/96/177c9667f8a87b10e3dd36fff6cd9e06.jpg"]),
             headline(tittle: AppLocalizations.popularDestinations) ,
             SizedBox(height:screenHeight(context)*.175 ,
              child: BlocBuilder<TripsCubit ,TripsStates>(
                builder: (context , states){
                  if (states is TripsStatesFailure){
                    return Center(child: Text("loading"),);
                  }else if (states is TripsStatesSuccess){
                    return ListView.builder(itemCount: states.trips.length,scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => cardV1(states.trips[index] , context , (){
                          context.push(AppRouter.tripScreen , extra: states.trips[index].id);
                        })
                    ) ;
                  }else{
                    return Center(child: CircularProgressIndicator(),) ;
                  }
                },
              ),
            
            ) ,
                verticalSpace(8),
                showMoreDistButton(context) ,
                headline(tittle: AppLocalizations.topActivities , hasViewMore: true) ,
                SizedBox( height:screenHeight(context)*.175 ,
                  child: ListView.builder(itemCount: 4,scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          cardV2(
                        "https://www.shouf.io/cdn/shop/files/img16_4b57d4a3-835a-4c1c-bebc-6b1393159828-138851-713982.jpg?v=1721223836" , context , "PARASAILING")
                  ),

                ) ,
                headline(tittle: AppLocalizations.topStore , hasViewMore: true) ,
                SizedBox( height:screenHeight(context)*.175,
                  child: ListView.builder(itemCount: 4,scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          cardV2(
                        "https://images.squarespace-cdn.com/content/v1/5a5c3110f6576e7552a4c667/1691537778615-ZGQVN4RFNSCLGLRU39AS/2023_PBA_Merch-89.jpg?format=1500w" , context , "POWER BOAT")
                  ),

                ) ,





              ],
                    ),
          ),
        );
  }
  Widget headline({required String tittle , bool? hasViewMore})=>  Padding(
    padding:  EdgeInsets.only(top: 8.0.h , bottom: 8.h),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tittle.toLowerCase() ,  style: AppTypography.t18Bold.copyWith(color: AppColors.secondaryColor),),
        hasViewMore == true ? Text(AppLocalizations.viewAll.toUpperCase() , style: AppTypography.t12Bold.copyWith(color: AppColors.secondaryColor),): SizedBox()
      ],
    ),
  ) ;
  Widget categoryItem(String img, String tittle )=>Column(
    children: [
      Container(
        width: 75.w,
        height: 75.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), // Rounded corners
          gradient: AppGradient.mainCategoriesGradient
        ),
        child: SvgPicture.asset(img),
      ) ,
      verticalSpace(2) ,
      Text(tittle.toUpperCase() , style: AppTypography.t12Bold.copyWith(color: AppColors.primaryColor ),)

    ],
  ) ;
  Widget cardV1(HomeModel model, context ,void Function()? onTap ) => Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 4.w),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: screenWidth(context) * .3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: CachedNetworkImageProvider(model.imgUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: model.imgUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => CachedImageHelper.imagePlaceholder(),
            errorWidget: (context, url, error) => CachedImageHelper.imageErrorWidget(),
          ),
        ),
      ),
    ),
  );  Widget cardV2(String imgUrl , context , String title)=>Padding(
    padding:  EdgeInsets.symmetric(horizontal: 4.0.w , vertical: 4.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: screenWidth(context)*.425 ,height: screenHeight(context)*.11,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8) , image: DecorationImage(image: NetworkImage(imgUrl) ,fit: BoxFit.cover )),
        ),
Spacer(),        Text(title , style: AppTypography.t14Normal.copyWith(color: AppColors.primaryColor , fontWeight: FontWeight.w300),) , Spacer()
      ],
    ),
  ) ;
  Widget showMoreDistButton(context)=>ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
    overlayColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    fixedSize: Size(screenWidth(context), 30.h),
    shadowColor: Colors.transparent,
    side: BorderSide(color: AppColors.primaryColor , width: 1.5),

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8) ,)
  ), child: Text(AppLocalizations.showMore , style: AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),) ,) ;
}
