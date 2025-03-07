import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/errors_widgets.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_button.dart';
import 'package:tjhaz/feature/profile/logic/personal_info_cubit.dart';
import 'package:tjhaz/feature/profile/logic/personal_info_state.dart';

import '../../../../core/database/local/shared_prefrences_constants.dart';
import '../../../../core/database/local/shared_prefrences_helper.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  @override
  void initState() {
    context.read<GetPersonalInfoCubit>().get(SharedPrefHelper.getString(SharedPrefConstants.currentUserId)!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: BlocBuilder<GetPersonalInfoCubit , GetPersonalInfoStates>(
              builder:  (context , state){
                if(state is GetPersonalInfoSuccess){
                  return   Column(
                    children: [
                      AppHeadline(tittle: "Personal Info") ,
                      verticalSpace(16.h) ,
                      textFormFieldOfPersonalInfo(hint: state.userModel.username ),
                      textFormFieldOfPersonalInfo(hint: state.userModel.birthDate??"No Birthdate Provided") ,
                      textFormFieldOfPersonalInfo(hint: state.userModel.emailAddress , enabled: false) ,
                      SizedBox(height: 320.h,) ,
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 80.0.w),
                        child: AuthButton(tittle: "Save", onPressed: (){} , bgColor: AppColors.secondaryColor,),
                      )



                    ],
                  )   ;
                }else if (state is GetPersonalInfoFailure){
                  return AppErrorWidget(error: state.errorMsg,) ;
                }else{
                  return CircularProgressIndicator(color: AppColors.secondaryColor,) ;
                }
              },

            ),
          ),
        ),
      ),



    );
  }

  Widget textFormFieldOfPersonalInfo({required String hint , bool enabled = true}) => Padding(
    padding:  EdgeInsets.symmetric(vertical: 4.0.h),
    child: SizedBox(
      height: 48.h,
      child: TextFormField(
        cursorColor: AppColors.secondaryColor,
        style: AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),

        decoration: InputDecoration(
          hintText: hint ,
          hintStyle: AppTypography.t12Normal.copyWith(color:enabled? AppColors.primaryColor  :AppColors.secondaryColor),
          enabled: enabled,
          filled: !enabled,
          fillColor: AppColors.secondaryColor.withOpacity(0.1),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8) , borderSide: BorderSide(color: AppColors.secondaryColor)) ,
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8) , borderSide: BorderSide(color: AppColors.primaryColor , width: 1.2)) ,
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8) , borderSide: BorderSide(color: Colors.red)) ,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8) , borderSide: BorderSide(color: AppColors.secondaryColor)) ,
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8) , borderSide: BorderSide(color: AppColors.secondaryColor)) ,



        ),
      ),
    ),
  ) ;
}
