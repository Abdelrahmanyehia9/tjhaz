import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/feature/shop/logic/products_cubit.dart';
import 'package:tjhaz/feature/shop/logic/vendors_cubit.dart';
import 'package:tjhaz/feature/shop/logic/vendors_states.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_headline.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../categories/view/widget/categories_containers.dart';
import '../../data/model/vendor_model.dart';
import '../widget/product_grid.dart';
class ShopScreen extends StatefulWidget {
  final int? activeCategory;
  const ShopScreen({super.key, this.activeCategory});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late ValueNotifier<int> activeIndex;
  late ValueNotifier<String> vendorName;
  @override
  void initState() {
    super.initState();
    activeIndex = ValueNotifier(widget.activeCategory ?? 0);
    vendorName = ValueNotifier("");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vendorsCubit = context.read<VendorCubit>();
      vendorsCubit.getAllVendors().then((_) {
        if (vendorsCubit.state is VendorsStatesSuccess) {
          final vendors = (vendorsCubit.state as VendorsStatesSuccess).vendors;
          if (vendors.isNotEmpty) {
            vendorName.value = vendors[activeIndex.value].name;
            if(mounted){
            context.read<ProductsCubit>().getAllProductByVendorID(vendors[activeIndex.value].id);
          }
          }
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GlobalAppBar(),
                AppHeadline(tittle: AppStrings.stores),
                BlocBuilder<VendorCubit, VendorsStates>(
                  builder: (context, state) {
                    if (state is VendorsStatesSuccess) {
                      List<VendorModel> vendors = state.vendors;

                      return SizedBox(
                        height: 110.h,
                        child: ValueListenableBuilder<int>(
                          valueListenable: activeIndex,
                          builder: (_, selectedIndex, __) {
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: vendors.length,
                              separatorBuilder: (context, _) => horizontalSpace(16),
                              itemBuilder: (context, index) {
                                final vendor = vendors[index];
                                return InkWell(
                                  onTap: () {
                                    activeIndex.value = index;
                                    vendorName.value = vendor.name;
                                    context.read<ProductsCubit>().getAllProductByVendorID(vendor.id);
                                  },
                                  child: RectangularCategory(
                                    isActive: selectedIndex == index,
                                    name: vendor.name.tr(),
                                    img: vendor.images.first,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                verticalSpace(16),
                ProductsGrid(vendorName: vendorName,)

              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    activeIndex.dispose();
    vendorName.dispose();
    super.dispose();
  }
}
