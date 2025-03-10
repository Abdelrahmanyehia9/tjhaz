import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/auth/logic/anonymous_user_cubit.dart';

class AnonymousScreen extends StatelessWidget {
  final Widget ifNotAnonymous ;
  const AnonymousScreen({super.key , required this.ifNotAnonymous});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnonymousUserCubit , bool>(
      builder: (context, anonymousUser) {
        if(anonymousUser){
          return Text("That is Anonymous") ;
        }else{
          return ifNotAnonymous ;
        }
      }
    );
  }
}
