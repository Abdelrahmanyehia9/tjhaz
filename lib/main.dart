import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/DI/dependency_injection.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/widgets/loading_widget.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'core/routes/app_router.dart';
import 'firebase_options.dart';


///to do shared preference
Locale currentLocale = Locale("ar", "KW");

void main() async {
  EntertainmentDetailsModel model = EntertainmentDetailsModel(
    entertainmentType: "2",
      categoryID: "9",
      id: "",
      name: {
        "EN":"kashta",
        "AR" : "كاشتا"
  },
      price: "40",
    details: {
      "EN":"Experience the absolute way of enjoying your quality time with family and friends. You'll have plenty of space and privacy on board, plus a beautiful sea view. This luxurious 65-foot yacht offers a capacity of 17 persons, ensuring a comfortable and spacious journey. Equipped with premium facilities, it features two lounges, a tanning area, a cozy bedroom, and two bathrooms. The air-conditioned interior includes a fully functional kitchen with a refrigerator, microwave, and café machine, along with a grill and icebox for your convenience. For entertainment, the yacht offers a television, a high-quality sound system, and fishing tools for adventure enthusiasts. The captain operates from an isolated space, ensuring a private and uninterrupted experience for guests. Additionally, the yacht is equipped with a tracking system for enhanced safety. Get ready for an unforgettable sea adventure and enjoy your trip!"
,"AR":"استمتع بتجربة فريدة لقضاء وقت ممتع مع العائلة والأصدقاء في أجواء من الفخامة والراحة. يوفر لك هذا اليخت الفاخر، الذي يبلغ طوله 65 قدمًا، مساحة واسعة وخصوصية تامة، بالإضافة إلى إطلالة ساحرة على البحر. بفضل سعته التي تصل إلى 17 شخصًا، يمكنك الاستمتاع برحلة بحرية مريحة ومميزة. يضم اليخت مرافق راقية تشمل صالتين فسيحتين، منطقة للتسمير، غرفة نوم أنيقة، وحمامين. يتميز التصميم الداخلي المكيف بمطبخ متكامل يحتوي على ثلاجة وميكروويف وماكينة قهوة، إلى جانب شواية وصندوق تبريد لحفظ المشروبات والمأكولات الطازجة. لمحبي الترفيه والمغامرة، يوفر اليخت تلفزيونًا، نظام صوتي عالي الجودة، وأدوات صيد للاستمتاع بتجربة بحرية فريدة. يعمل القبطان في منطقة معزولة، مما يضمن للضيوف تجربة خاصة دون أي انقطاع. ولتعزيز الأمان، تم تجهيز اليخت بنظام تتبع حديث. استعد لخوض مغامرة بحرية لا تُنسى واستمتع برحلتك!"
    },
      description: {
      "EN":"Experience the absolute way of enjoying your quality time with family and friends. You'll have plenty of space and privacy on board plus a beautiful sea view. Yacht size: 65 ftCapacity: 17 PersonsFacilities: 2Lounges, Tan Area, 1 Bedroom, 2 Toilet, Air Condition, Kitchen, Refrigerator, microwave, Television, Grill, icebox, Café Machine, Fishing Tools, Sound system, Cutlery Captain is isolatedThe yacht is equipped with a tracking systemHappy trip!",
      "AR":"استمتع بتجربة مثالية لقضاء وقت ممتع مع العائلة والأصدقاء على متن يخت فاخر يوفر لك مساحة واسعة وخصوصية تامة، إلى جانب إطلالة خلابة على البحر. يبلغ طول اليخت 65 قدمًا، ويستوعب ما يصل إلى 17 شخصًا، مما يجعله خيارًا مثاليًا للرحلات البحرية الجماعية. تم تجهيز اليخت بمرافق راقية تضمن لك الراحة والرفاهية، حيث يضم صالتين فسيحتين، منطقة مخصصة للتسمير، غرفة نوم أنيقة، وحمامين. كما يحتوي على مطبخ متكامل مزود بثلاجة وميكروويف وماكينة قهوة، إلى جانب شواية وصندوق تبريد لحفظ المشروبات والمأكولات الطازجة. للاستمتاع بأجواء ترفيهية، يوفر اليخت نظام صوتي متطور وتلفزيون، بالإضافة إلى أدوات صيد لمحبي المغامرات البحرية. لضمان أقصى درجات الأمان والراحة، تم تجهيز اليخت بنظام تتبع، كما يتمتع القبطان بمقصورة معزولة تضمن لك خصوصية كاملة أثناء الرحلة. استعد لرحلة بحرية لا تُنسى واستمتع بأجمل اللحظات على متن هذا اليخت الفاخر."
      },
      images: ["https://static.listmag.com/styles/large/public/inline-images/Kashta%20Camping%20Saudi%20.jpg"
        , "https://c8.alamy.com/comp/2GDDCFX/arabian-nights-overland-outdoor-adventure-trip-2GDDCFX.jpg"
      ],
      time: "1",
      rates: "3.4",
      ratingCount: 123 ,
    location: {
        "EN":"Ras Al Ard Porto",
      "AR":"راس الارض بورتو"
    },



  ) ;
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
          overlayColor: AppColors.cWhite.withOpacity(0.5),
          overlayWidgetBuilder: (_){
            return LoadingWidgetAnimation() ;
          },
          child: TjhazApp())));
}

class TjhazApp extends StatelessWidget {
  const TjhazApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),

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
    );
  }
}

