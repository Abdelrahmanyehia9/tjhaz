import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/DI/dependency_injection.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_model.dart';
import 'core/routes/app_router.dart';
import 'firebase_options.dart';


///to do shared preference
Locale currentLocale = Locale("ar", "KW");

void main() async {
  EntertainmentModel model = EntertainmentModel(
      id: "diving_001",
      name: {
        "EN": "Scuba Diving Adventure",
        "AR": "مغامرة الغوص تحت الماء"
      },
      description: {
        "EN": "Experience the thrill of scuba diving in crystal-clear waters. Explore stunning coral reefs and diverse marine life while being guided by professional divers. Suitable for beginners and experienced divers.",
        "AR": "استمتع بإثارة الغوص في المياه الصافية، واكتشف الشعاب المرجانية الخلابة والحياة البحرية المتنوعة مع غواصين محترفين. مناسب للمبتدئين والغواصين ذوي الخبرة."
      },
      images: [
        "https://www.princesstourism.com/wp-content/uploads/2023/05/GettyImages-597572085-584819855f9b5851e593fd0b-5c336fd646e0fb0001d39014.jpg",
        "https://sustainabletravel.org/wp-content/uploads/Blog-Header-Diver-School-of-Fish.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Discover_Scuba_Diving_--_St._Croix%2C_US_Virgin_Islands.jpg/800px-Discover_Scuba_Diving_--_St._Croix%2C_US_Virgin_Islands.jpg"
      ],
      time: "4",
      rates: "3.5",
      ratingCount: 125,
      guests: 10,
      location: {
        "EN": "Red Sea, Egypt",
        "AR": "البحر الأحمر، مصر"
      },
      details: {
        "EN": "This six-hour scuba diving adventure offers an unforgettable experience in the depths of the Red Sea. Equipped with high-quality diving gear, you will receive a thorough safety briefing and a basic training session before beginning your dive. A professional instructor will accompany you throughout the journey, ensuring your safety and enhancing your underwater experience. As you descend, you will be mesmerized by the vibrant coral reefs and the incredible variety of marine life. An underwater photography session will be included to capture these breathtaking moments. After your dive, you can relax on the boat, enjoying refreshments and light snacks while taking in the stunning ocean view. For those seeking an enhanced experience, additional services such as underwater video recording, private instructors, and deep-sea diving for certified divers are available at an extra cost. The trip also includes convenient transportation from your hotel to the diving site, making the entire experience smooth and hassle-free.",
        "AR": "تقدم لك هذه المغامرة في الغوص تحت الماء، التي تمتد لست ساعات، تجربة لا تُنسى في أعماق البحر الأحمر. سيتم تزويدك بمعدات غوص عالية الجودة، كما ستحصل على إحاطة شاملة حول إجراءات السلامة وجلسة تدريبية أساسية قبل بدء الغوص. سيرافقك مدرب محترف طوال الرحلة لضمان سلامتك وتعزيز تجربتك تحت الماء. أثناء الغوص، ستنبهر بجمال الشعاب المرجانية وتنوع الحياة البحرية الفريد. كما سيتم التقاط صور احترافية لك تحت الماء لتوثيق هذه اللحظات المذهلة. بعد انتهاء الغوص، يمكنك الاسترخاء على متن القارب والاستمتاع بالمشروبات والوجبات الخفيفة أثناء مشاهدة المناظر الخلابة للمحيط. لأولئك الذين يبحثون عن تجربة أكثر إثارة، تتوفر خدمات إضافية مثل تسجيل فيديو احترافي تحت الماء، وجود مدرب خاص، والغوص في أعماق البحر للغواصين المعتمدين مقابل تكلفة إضافية. تشمل الرحلة أيضًا خدمة النقل المريحة من الفندق إلى موقع الغوص، مما يجعل التجربة سهلة وخالية من المتاعب."
      },
    price: "125"

  );

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
      child: TjhazApp()));
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

Future<void> addNewActivity(EntertainmentModel model) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore.collection("activities").add(
      model.toJson());
}