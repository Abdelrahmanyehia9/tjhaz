import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/app_message.dart';
import 'package:tjhaz/feature/auth/logic/anonymous_user_cubit.dart';
import 'package:tjhaz/feature/auth/logic/logout_states.dart';
import 'package:tjhaz/feature/auth/logic/logout_cubit.dart';
import 'package:tjhaz/feature/profile/view/widgets/profile_button.dart';
import 'package:toastification/toastification.dart';
import '../widgets/language_toggle.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {




  @override
  void initState() {
context.read<AnonymousUserCubit>().checkAnonymousUser()  ;
super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BlocBuilder<AnonymousUserCubit , bool>(
                builder:(context , isAnonymous)=> Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    verticalSpace(16) ,
                    AppHeadline(tittle: AppStrings.profile , hasBackButton: false,),
                    verticalSpace(8) ,
                    ProfileButton(text: "personal info"  , visible: !isAnonymous ,icon:  Icons.person , onPressed: (){
                      context.push(AppRouter.personalInfoScreen , ) ;
                    },),
                    ProfileButton(text: "Login" , visible: isAnonymous ,icon:  Icons.login , filled: true, onPressed: (){
                     if(context.mounted) context.go(AppRouter.authScreen) ;
                    },),
                    ProfileButton(text: "reset password" , visible: !isAnonymous ,icon:  Icons.lock),
                    ProfileButton(text: "My Favorites" ,visible: !isAnonymous ,icon:  Icons.favorite , onPressed: (){
                      context.push(AppRouter.favoriteScreen) ;
                    },),
                    ProfileButton(text: "contact us"  ,visible: true ,icon:  Icons.support_agent),
                    ProfileButton(text: "my orders", visible: !isAnonymous  ,icon:  Icons.receipt),
                    ProfileButton(text: "my bookings", visible: !isAnonymous  ,icon:  Icons.calendar_today , onPressed: (){
                      context.push(AppRouter.bookingsScreen ,) ;
                    },),
                    ProfileButton(text: "about us", visible: true   ,icon:  Icons.contact_support),
                    BlocListener<LogoutCubit , LogoutStates>(
                      listener: (context , state){
                        if(state is LogoutStatesFailure){
                          appToast(type: ToastificationType.error, tittle: "logout Failed", description: state.errorMsg) ;
                        }else if(state is LogoutStatesSuccess){
                          appToast(type: ToastificationType.success, tittle: "Logout success", description: "You logged out successfully") ;
                          context.go(AppRouter.authScreen) ;
                        }
                      },
                      child: ProfileButton(text: "Logout", visible: !isAnonymous  ,icon:  Icons.logout , onPressed: (){
                        context.read<LogoutCubit>().logout() ;
                      },),
                    ),
                    verticalSpace(16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("تغيير اللغة" , style: AppTypography.t11Bold.copyWith(color: AppColors.primaryColor),),
                    ) ,
                    LanguageToggle() ,
                    verticalSpace(16) ,
                    profileFooter() ,
                    verticalSpace(16) ,


                  ],
                ),
              ),
              BlocBuilder<LogoutCubit ,  LogoutStates>(
                builder:(context  , state) => Visibility(
                  visible: state is LogoutStatesLoading,
                  child: SizedBox(
                    width: 120.w,
                    height: 220.h,
                    child: Lottie.asset("assets/images/bye.json" , fit: BoxFit.cover),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

Widget profileFooter() {
    return  Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Privacy And Policies\t |\t Terms and Conditions" , style: AppTypography.t12Normal.copyWith(color: AppColors.cDarkGrey),) ,
          verticalSpace(2) ,
          Text("version 1.0.0" , style: AppTypography.t11Light.copyWith(color: AppColors.secondaryColor),)
        ],
      ),
    ) ;

}
}
