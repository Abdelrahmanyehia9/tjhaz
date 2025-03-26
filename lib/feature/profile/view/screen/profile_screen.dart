import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
import 'package:tjhaz/feature/profile/view/widgets/about_us.dart';
import 'package:tjhaz/feature/profile/view/widgets/profile_button.dart';
import 'package:toastification/toastification.dart';
import '../widgets/language_toggle.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String appVersion = "";

  @override
  void initState() {
    super.initState();
    context.read<AnonymousUserCubit>().checkAnonymousUser();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<AnonymousUserCubit, bool>(
                builder: (context, isAnonymous) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(16),
                    AppHeadline(tittle: AppStrings.profile),
                    verticalSpace(8),
                    ProfileButton(
                      text: AppStrings.personalInformation,
                      visible: !isAnonymous,
                      icon: Icons.person,
                      onPressed: () => context.push(AppRouter.personalInfoScreen),
                    ),
                    ProfileButton(
                      text: AppStrings.login,
                      visible: isAnonymous,
                      icon: Icons.login,
                      filled: true,
                      onPressed: () {
                        if (context.mounted) context.go(AppRouter.authScreen);
                      },
                    ),
                    ProfileButton(text: AppStrings.resetPassword, visible: !isAnonymous, icon: Icons.lock),
                    ProfileButton(
                      text: AppStrings.myFavourites,
                      visible: !isAnonymous,
                      icon: Icons.favorite,
                      onPressed: () => context.push(AppRouter.favoriteScreen),
                    ),
                    ProfileButton(
                      text: AppStrings.contactUs,
                      visible: true,
                      icon: Icons.support_agent,
                      onPressed: () => context.push(AppRouter.contactUsScreen),
                    ),
                    ProfileButton(text: AppStrings.myOrders, visible: !isAnonymous, icon: Icons.receipt),
                    ProfileButton(
                      text: AppStrings.myBookings,
                      visible: !isAnonymous,
                      icon: Icons.calendar_today,
                      onPressed: () => context.push(AppRouter.bookingsScreen),
                    ),
                    ProfileButton(
                      text: AppStrings.aboutUs,
                      visible: true,
                      icon: Icons.contact_support,
                      onPressed: () => showAboutUs(context),
                    ),
                    BlocListener<LogoutCubit, LogoutStates>(
                      listener: (context, state) {
                        if (state is LogoutStatesFailure) {
                          appToast(
                            type: ToastificationType.error,
                            tittle: AppStrings.logoutFailed,
                            description: state.errorMsg,
                          );
                        } else if (state is LogoutStatesSuccess) {
                          appToast(
                            type: ToastificationType.success,
                            tittle: AppStrings.logoutSuccess,
                            description: AppStrings.loggedOutSuccess,
                          );
                          context.go(AppRouter.authScreen);
                        }
                      },
                      child: ProfileButton(
                        text: AppStrings.logout,
                        visible: !isAnonymous,
                        icon: Icons.logout,
                        onPressed: () => context.read<LogoutCubit>().logout(),
                      ),
                    ),
                    verticalSpace(16),
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Text(
                        AppStrings.changeLanguage,
                        style: AppTypography.t11Bold.copyWith(color: AppColors.primaryColor),
                      ),
                    ),
                    const LanguageToggle(),
                    verticalSpace(24),
                    profileFooter(),
                    verticalSpace(24),
                  ],
                ),
              ),
              BlocBuilder<LogoutCubit, LogoutStates>(
                builder: (context, state) => Visibility(
                  visible: state is LogoutStatesLoading,
                  child: SizedBox(
                    width: 120.w,
                    height: 240.h,
                    child: Lottie.asset("assets/images/bye.json", fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileFooter() {
    return Center(
      child: Column(
        children: [
          Text(
            "${AppStrings.privacyPolicy} | ${AppStrings.termsAndConditions}",
            style: AppTypography.t12Normal.copyWith(color: AppColors.cDarkGrey),
          ),
          verticalSpace(2),
          Text(
            "${AppStrings.version} $appVersion",
            style: AppTypography.t11Light.copyWith(color: AppColors.secondaryColor),
          ),
        ],
      ),
    );
  }
}
