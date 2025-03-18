import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_back_button.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/global_app_bar.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/app_assets.dart';

void showAboutUs(BuildContext context) {
  Widget titleAndDescription({required String title , required String description})=>Padding(
    padding:  EdgeInsets.all(16.0.w),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),) ,
          verticalSpace(4)  ,
          Text(description , style: AppTypography.t10Normal.copyWith(color: AppColors.lightPrimaryColor),)
        ]
    ),
  ) ;

  showModalBottomSheet(
    isScrollControlled: true,

    context: context, builder: (_)=>   Container(
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r) , topRight: Radius.circular(16.r))

     ),

  height: MediaQuery.of(context).size.height-140.h,
  width: double.infinity,
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              height: 140.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  image: DecorationImage(image: AssetImage(AppAssets.seaTrip) ,alignment: Alignment.bottomLeft, fit: BoxFit.cover , colorFilter: ColorFilter.mode(AppColors.lightPrimaryColor, BlendMode.darken))
              ),
              child : Image.asset(AppAssets.appLogo , fit: BoxFit.cover,) ,
            ),
            Padding(
              padding:  EdgeInsets.all(16.0.w),
              child: InkWell(
                onTap: (){
                  context.pop() ;
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  child: const Icon(Icons.arrow_back , color: Colors.white,),
                ),
              ),
            )
          ],
        ) ,

        // SizedBox(
        //     width: 150.w,height: 80.h,
        //     child: Image.asset(AppAssets.splashLogo)) ,
        titleAndDescription(
            title: "عن تجهز",
            description: "مرحبًا بكم في تجهز، وجهتكم الرسمية للحصول على تجربة فريدة واحترافية تجمع بين الرحلات البحرية الممتعة، الأنشطة الترفيهية، والتسوق الإلكتروني. نحن في تجهز ملتزمون بتقديم خدمات مبتكرة وموثوقة تلبي جميع احتياجاتكم بأسلوب سهل وآمن، مع التركيز على تقديم أعلى معايير الجودة والراحة في جميع خدماتنا."
        ),

        titleAndDescription(
            title: "رؤيتنا",
            description: "أن نكون المنصة الرائدة في تقديم الحلول البحرية، الخدمات الترفيهية، وتجربة التسوق الإلكترونية. من خلال تقديم تجارب استثنائية تلبي تطلعات جميع مستخدمينا في بيئة آمنة ومتكاملة."
        ),

        titleAndDescription(
            title: "تأجير القوارب واليخوت",
            description: "نقدم لكم فرصًا فريدة للاستمتاع برحلات بحرية لا تُنسى. سواء كانت رحلات صيد أو ترفيهية، يمكنكم استئجار القوارب واليخوت عبر تطبيقنا أو الموقع الإلكتروني بكل سهولة وأمان."
        ),

        titleAndDescription(
            title: "تأجير الشاليهات",
            description: "احجزوا شاليهكم المثالي في مواقع مميزة، واستمتعوا بوقت هادئ ومريح في بيئة طبيعية، بعيدًا عن ضغوط الحياة اليومية."
        ),

        titleAndDescription(
            title: "الكشتات والأنشطة المائية",
            description: "استمتعوا بتجربة مغامرات صحراوية وأنشطة مائية ممتعة تلائم كافة الأعمار، مع ضمان أعلى مستويات الأمان والراحة أثناء النشاطات."
        ),

        titleAndDescription(
            title: "خدمات الطعام على اليخوت",
            description: "نقدم لكم تجربة طعام مميزة على متن اليخوت، مع مجموعة متنوعة من الوجبات الفاخرة التي تناسب مختلف الأذواق، مما يجعل كل رحلة بحرية أكثر تميزًا."
        ),

        titleAndDescription(
            title: "التسوق عبر الإنترنت",
            description: "يمكنكم تصفح مجموعة واسعة من المتاجر الإلكترونية التي تقدم لكم أفضل المنتجات من المعدات البحرية، ملابس البحر، أدوات الغوص، وغير ذلك الكثير. كل ذلك متاح لكم بسهولة ويسر عبر تطبيقنا أو الموقع الإلكتروني."
        ),

        titleAndDescription(
            title: "حجوزات سريعة وسهلة",
            description: "احجزوا تجربتكم بكل سهولة وسرعة من خلال تطبيقنا المتاح على أنظمة Android وiOS أو عبر الموقع الإلكتروني، مما يضمن لكم تجربة سلسة ومريحة."
        ),

        titleAndDescription(
            title: "دفع مرن وآمن",
            description: "نقدم لكم خيارات دفع متعددة وآمنة تشمل K-Net، Visa، وMasterCard، لضمان تجربة تسوق مريحة وآمنة."
        ),

        titleAndDescription(
            title: "لماذا تختارون تجهز؟",
            description: "منصة موثوقة ومتطورة تقدم خدمات بحرية وترفيهية من الدرجة الأولى. واجهة مستخدم سهلة وسريعة عبر تطبيقنا وموقعنا الإلكتروني www.tajhezapp.com. دعم فني متواصل على مدار الساعة لضمان راحتكم ورضاكم. انضموا إلينا اليوم!"
        ),

        titleAndDescription(
            title: "اختبروا تجربة لا تُنسى مع تجهز",
            description: "حيث نقدم لكم أعلى مستويات الخدمة والراحة في كل لحظة."
        ),



      ],
    ),
  ),
)

   );
   
   
   
   
}