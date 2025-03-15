import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/DI/dependency_injection.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/routes/index.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/widgets/lottie_widget.dart';
import 'package:tjhaz/feature/booking/data/repository/bookings_repository.dart';
import 'package:tjhaz/feature/booking/logic/booking/add_new_booking_cubit.dart';
import 'package:tjhaz/feature/auth/logic/anonymous_user_cubit.dart';
import 'package:tjhaz/feature/cart/data/repository/cart_repository.dart';
import 'package:tjhaz/feature/cart/logic/cart_cubit.dart';
import 'package:tjhaz/feature/cart/logic/cart_modify_cubit.dart';
import 'package:tjhaz/feature/favorite/data/repository/favorite_repository.dart';
import 'package:tjhaz/feature/favorite/logic/add_or_remove_to_favorite_cubit.dart';
import 'package:tjhaz/feature/favorite/logic/get_all_favorite_cubit.dart';
import 'package:toastification/toastification.dart';
import 'core/database/local/shared_prefrences_helper.dart';
import 'core/routes/app_router.dart';
import 'feature/entertainment/logic/entertainment_details_cubit.dart';
import 'firebase_options.dart';

///to do shared preference
Locale currentLocale = Locale("en", "IN");

void main() async {
  ProductModel model = ProductModel(id: "", inStock: 3, description: {
    "EN":"discription" ,
  "AR":"وصف " ,
  }, images: ["https://m.media-amazon.com/images/I/61ojTzKZR4L.__AC_SX300_SY300_QL70_ML2_.jpg"], name: {"EN":"Qisah" , "AR": "خيمة"}, vendor:"VwK9Wh6m6MLm2dpl6Zt6", price: 125.0, priceBeforeDiscount: 200.0, tags: ["tag1", "tag2"]);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPrefHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();

  runApp(EasyLocalization(
      supportedLocales: [Locale('en', "IN"), Locale('ar', "KW")],
      path: 'assets/lang',
      startLocale: currentLocale,
      fallbackLocale: Locale('en', "IN"),
      child: GlobalLoaderOverlay(
          overlayColor: Colors.white.withOpacity(0.8),
          overlayWidgetBuilder: (_) {
            return LottieAnimation();
          },
          child: TjhazApp())));
}

class TjhazApp extends StatelessWidget {
  const TjhazApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => EntertainmentDetailsCubit(
                  getIt.get<EntertainmentRepository>())),
          BlocProvider(
              create: (context) =>
                  AddNewBookingCubit(getIt.get<BookingRepository>())),
          BlocProvider(
              create: (context) =>
                  AddOrRemoveToFavoriteCubit(getIt.get<FavoriteRepository>())),
          BlocProvider(
              create: (context) =>
                  GetAllFavoriteCubit(getIt.get<FavoriteRepository>())..get()),
          BlocProvider(
            create: (context) => AddNewBookingCubit(
              getIt.get<BookingRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CartModifyCubit(
              getIt.get<CartRepository>(),
            ),
          ),   BlocProvider(
            create: (context) => CartCubit(
              getIt.get<CartRepository>(),
            ),
          ),
        ],
        child: ToastificationWrapper(
          child: MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.scaffoldBackground,
              primaryColor: AppColors.primaryColor,
              splashColor: Colors.transparent,
              fontFamily: 'alex',
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.routes,
          ),
        ),
      ),
    );
  }
}

Future<void> addItem(ProductModel model) async {
  await FirebaseFirestore.instance
      .collection(FireStoreConstants.productCollection)
      .add(model.toJson());
}
