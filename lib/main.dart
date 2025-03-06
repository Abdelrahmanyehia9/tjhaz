import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'package:tjhaz/feature/shop/data/model/vendor_model.dart';
import 'package:toastification/toastification.dart';
import 'core/routes/app_router.dart';
import 'feature/booking/data/model/reservation_model.dart';
import 'feature/categories/data/repository/categories_repository.dart';
import 'feature/categories/logic/categories_cubit.dart';
import 'feature/entertainment/data/repository/entertainment_repository.dart';
import 'feature/entertainment/logic/entertainment_details_cubit.dart';
import 'feature/shop/data/model/product_mode.dart';
import 'firebase_options.dart';


///to do shared preference
Locale currentLocale = Locale("ar", "KW");

void main() async {



  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
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
          BlocProvider(create: (context) => AddNewBookingCubit(getIt.get<BookingRepository>())),

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


Future<void> addItem(ReservationModel model) async {
  await FirebaseFirestore.instance.collection(
      FireStoreConstants.entertainment).doc("CdK1PomBcxVqBasGOALx").collection(FireStoreConstants.reservationCollection).doc(DateTime.now().month.toString()).set(model.toJson()) ;
}

