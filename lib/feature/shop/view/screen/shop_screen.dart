import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/styles/card_sizes.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/core/utils/constants.dart';
import 'package:tjhaz/core/widgets/cards/product_card.dart';
import 'package:tjhaz/core/widgets/error_widget.dart';
import 'package:tjhaz/feature/entertainment/view/widget/entertainment_loading.dart';
import 'package:tjhaz/feature/shop/logic/products_cubit.dart';
import 'package:tjhaz/feature/shop/logic/products_states.dart';
import 'package:tjhaz/feature/shop/logic/vendors_cubit.dart';
import 'package:tjhaz/feature/shop/logic/vendors_states.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_headline.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../categories/view/widget/rectangular_categories.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _activeIndex = 0;

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
                AppHeadline(tittle: AppLocalizationsString.stores),
                BlocConsumer<VendorCubit , VendorsStates>(
                  builder: (context , state)=> state is VendorsStatesSuccess ? SizedBox(
                  height: 110.h,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,

                      itemBuilder: (context, index) {
                        final vendor = state.vendors[index] ;
                        return InkWell(
                        onTap: () async {
                          setState(() {
                            _activeIndex = index;
                          });
                          await context.read<ProductsCubit>().getAllProductByVendorID(state.vendors[_activeIndex].id) ;
                        },
                        child: RectangularCategory(
                          isActive: _activeIndex == index,
                          name: vendor.name,
                          img: vendor.images.first
                        ),
                      );
                      },
                      separatorBuilder: (context, state) => horizontalSpace(16),
                      itemCount: state.vendors.length),
                ): SizedBox() ,
                  listener: (context , state){
                   if(state is VendorsStatesSuccess){
                     context.read<ProductsCubit>().getAllProductByVendorID(state.vendors[_activeIndex].id) ;
                   }
                  },
                ),
                verticalSpace(16),
                BlocBuilder<ProductsCubit  , ProductsStates>(
                  builder: (context , state){
                    if (state is ProductsStatesSuccess){
                      return GridView.builder(
                          shrinkWrap: true,
                          // Makes GridView take only needed space
                          physics: const NeverScrollableScrollPhysics(),
                          // Disable GridView's scrolling
                          itemCount: state.products.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: CardSizes.productCard.width /
                                CardSizes.productCard.height,
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                          ),
                          itemBuilder: (context, index) => InkWell(
                            onTap: (){
                              context.push(AppRouter.shopDetailsScreen , extra:  state.products[index]) ;
                            },
                              child: ProductCard(productModel: state.products[index],))) ;
                    }else if (state is ProductsStatesFailure){
                      return AppErrorWidget(error: state.error,)  ;
                    }else{
                      return EntertainmentGridLoading() ;
                    }
                  },

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
