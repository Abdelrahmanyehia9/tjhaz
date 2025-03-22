import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/database/remote/firestore_constants.dart';
import 'package:tjhaz/core/routes/index.dart';
import 'package:tjhaz/core/theme/light.dart';
import 'package:tjhaz/core/utils/app_constants.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/lottie_widget.dart';
import 'package:tjhaz/feature/booking/logic/booking/add_new_booking_cubit.dart';
import 'package:tjhaz/feature/cart/data/repository/cart_repository.dart';
import 'package:tjhaz/feature/cart/logic/cart_cubit.dart';
import 'package:tjhaz/feature/favorite/data/repository/favorite_repository.dart';
import 'package:toastification/toastification.dart';
import 'core/database/local/shared_prefrences_helper.dart';
import 'core/routes/app_router.dart';
import 'feature/entertainment/logic/entertainment_details_cubit.dart';
import 'feature/favorite/logic/favorite_cubit.dart';
import 'firebase_options.dart';

///to do shared preference

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPrefHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      startLocale:  Locale(AppConstants.currentLocale),
      fallbackLocale: const Locale('en',),
      child: GlobalLoaderOverlay(
          overlayColor: Colors.white.withOpacity(0.8),
          overlayWidgetBuilder: (_) {
            return const LottieAnimation();
          },
          child: const TjhazApp())));
}

class TjhazApp extends StatelessWidget {
  const TjhazApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => EntertainmentDetailsCubit(
                  getIt.get<EntertainmentRepository>())),
          BlocProvider(
              create: (context) =>
                  AddNewBookingCubit(getIt.get<BookingRepository>())),
          BlocProvider(
            create: (context) => FavoriteCubit(
              getIt.get<FavoriteRepository>(),
            ),
          ),
          // BlocProvider(
          //   create: (context) => CartModifyCubit(
          //     getIt.get<CartRepository>(),
          //   ),
          // ),
          BlocProvider(
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
            // theme: ThemeData(
            //   scaffoldBackgroundColor: AppColors.scaffoldBackground,
            //   primaryColor: AppColors.primaryColor,
            //   splashColor: Colors.transparent,
            //   fontFamily: 'alex',
            //   highlightColor: Colors.transparent,
            //   hoverColor: Colors.transparent,
            // ),
            theme: AppThemeData.lightTheme,
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
