import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

appToast(
    {BuildContext? context,
      required ToastificationType type,
      required String tittle,
          ToastificationStyle?   style ,
      required String description}) => toastification.show(
    alignment: Alignment.bottomCenter,
    showProgressBar: true,
    autoCloseDuration: Duration(seconds: 3),
    type: type,
    style: style ?? ToastificationStyle.fillColored,
    title: Text(tittle),
    description: Text(description),
    context: context);
