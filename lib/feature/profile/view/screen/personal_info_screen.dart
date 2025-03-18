import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_assets.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/errors_widgets.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_button.dart';
import 'package:tjhaz/feature/profile/logic/personal_info_cubit.dart';
import 'package:tjhaz/feature/profile/logic/personal_info_state.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/database/local/shared_prefrences_constants.dart';
import '../../../../core/database/local/shared_prefrences_helper.dart';
import '../../../../core/widgets/app_message.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../auth/data/models/user_model.dart';
class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}
class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  @override
  void initState() {
    context
        .read<PersonalInfoCubit>().get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocConsumer<PersonalInfoCubit, PersonalInfoStates>(
            listener: (context, state) {
              if (state is UpdatePersonalInfoSuccess) {
                appToast(
                    type: ToastificationType.success,
                    tittle: AppStrings.profileUpdatedSuccess,
                    description: AppStrings.personalInfoUpdated);
              } else if (state is UpdatePersonalInfoFailure) {
                appToast(
                    type: ToastificationType.error,
                    tittle: AppStrings.profileUpdatedFailed,
                    description: state.errorMsg);
              }
            },
            builder: (context, state) {
              if (state is GetPersonalInfoSuccess ||
                  state is UpdatePersonalInfoSuccess ||
                  state is UpdatePersonalInfoFailure) {
                UserModel userModel =
                    context.read<PersonalInfoCubit>().userModel!;
                return Column(
                  children: [
                    verticalSpace(36) ,
                    const AppLogoImage() ,
                    verticalSpace(16),
                    AppHeadline(tittle: AppStrings.personalInformation , topPadding: 0,),
                    verticalSpace(16),
                    Expanded(
                      child: ListView(
                        children: [
                          textFormFieldOfPersonalInfo(
                              hint: userModel.username,
                              controller: userNameController),
                          textFormFieldOfPersonalInfo(
                            onTap: (){
                              showDatePicker(

                                  context: context, firstDate: DateTime(1900), lastDate: DateTime.now(), initialDate: DateTime.now()).then((value) {
                                  value == null ? null : birthDateController.text = DateFormat('yyyy-MM-dd').format(value) ;
                              }) ;
                            },
                              hint: userModel.birthDate ??
                                  AppStrings.noBirthdateProvided,
                              keyboardType: TextInputType.none,
                              controller: birthDateController),
                          textFormFieldOfPersonalInfo(
                            hint: userModel.emailAddress,
                            enabled: false,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.0.w),
                      child: AuthButton(
                        tittle: AppStrings.save,
                        onPressed: () async{
                          await updatePersonalInfo(userModel , context);
                        } ,
                        bgColor: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                );
              } else if (state is GetPersonalInfoFailure) {
                return Center(child: AppErrorWidget(error: state.errorMsg));
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.secondaryColor),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget textFormFieldOfPersonalInfo({
    GestureTapCallback? onTap ,
    required String hint,
    bool enabled = true,
    TextEditingController? controller,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: SizedBox(
        height: 48.h,
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          cursorColor: AppColors.secondaryColor,
          onTap: onTap,
          keyboardType: keyboardType,
          style:
              AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),
          decoration: InputDecoration(

            hintText: hint,
            hintStyle: AppTypography.t12Normal.copyWith(
              color:
                  enabled ? AppColors.primaryColor : AppColors.secondaryColor,
            ),
            enabled: enabled,
            filled: !enabled,

            fillColor: AppColors.secondaryColor.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryColor , width: 1.5),
            ),


          ),
        ),
      ),
    );
  }
  Future<void> updatePersonalInfo(UserModel userModel , BuildContext context) async {

    UserModel updatedUser = UserModel(
        uID: userModel.uID,
        username: userNameController.text.isEmpty
            ? userModel.username
            : userNameController.text.trim(),
        emailAddress: userModel.emailAddress,
        birthDate: birthDateController.text.isEmpty
            ? userModel.birthDate
            : birthDateController.text.trim());
    context.loaderOverlay.show() ;
    await context.read<PersonalInfoCubit>().update(updatedUser) ;
    if (context.mounted) context.loaderOverlay.hide() ;
  }

}
