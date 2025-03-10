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
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/widgets/lottie_widget.dart';
import 'package:tjhaz/feature/booking/data/repository/bookings_repository.dart';
import 'package:tjhaz/feature/booking/logic/booking/add_new_booking_cubit.dart';
import 'package:tjhaz/feature/auth/logic/anonymous_user_cubit.dart';
import 'package:tjhaz/feature/favorite/data/repository/favorite_repository.dart';
import 'package:tjhaz/feature/favorite/logic/add_or_remove_to_favorite_cubit.dart';
import 'package:tjhaz/feature/favorite/logic/get_all_favorite_cubit.dart';
import 'package:toastification/toastification.dart';
import 'core/database/local/shared_prefrences_helper.dart';
import 'core/routes/app_router.dart';

import 'feature/entertainment/data/model/entertainment_details_model.dart';
import 'feature/entertainment/data/repository/entertainment_repository.dart';
import 'feature/entertainment/logic/entertainment_details_cubit.dart';
import 'firebase_options.dart';


///to do shared preference
Locale currentLocale = Locale("ar", "KW");

void main() async {
  EntertainmentDetailsModel model = EntertainmentDetailsModel(
      availableFrom: 12,
      availableTo: 10,
      minHoursToBooking: 1,
      id: "id",
      name: "diving",
      categoryID: "8",
      location: "location",
      description: "description",
      entertainmentType: "1",
      facilities: {
        "area":"120",
        "bathroom":2 ,
        "bedroom":2,
        "captin":"Egyptian",
        "guests":4 ,
        "halls":1 ,


      },
      comfortFacilities: ["AC", "Wifi" , "TV" , "Sound System"],
      images: ["https://www.sunrise-divers.com/wp-content/uploads/2017/02/diver-fish-clear-water.jpg" , "https://imgds360live.s3.amazonaws.com/storefront/3179043/7646062514_1672706356_3179043.jpg"],
      price: 56,
      guests: 4,
      rates: "4.2",
      ratingCount: 234) ;

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
          BlocProvider(create: (context) =>
              EntertainmentDetailsCubit(getIt.get<EntertainmentRepository>())),
          BlocProvider(create: (context) =>
              AnonymousUserCubit(getIt.get<FirebaseAuth>())),
          BlocProvider(create: (context) =>
              AddNewBookingCubit(getIt.get<BookingRepository>())),
          BlocProvider(create: (context) =>
              AddOrRemoveToFavoriteCubit(getIt.get<FavoriteRepository>())),
          BlocProvider(create: (context) =>
              GetAllFavoriteCubit(getIt.get<FavoriteRepository>())..get()),

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


Future<void> addItem(EntertainmentDetailsModel model) async {
  await FirebaseFirestore.instance.collection(
      FireStoreConstants.entertainment).add(model.toJson()) ;
}

