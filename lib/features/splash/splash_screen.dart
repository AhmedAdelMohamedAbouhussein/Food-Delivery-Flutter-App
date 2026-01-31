import 'dart:async';
import 'package:final_proj/core/resources/app_icons.dart';
import 'package:final_proj/features/home/signin_screen.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget
{
    const SplashScreen({super.key});
    @override
    Widget build(BuildContext context)
    {
        _init(context);
        return Scaffold(body: Center(child:Image.asset(AppIcons.splashLogo)));
    }
    void _init(BuildContext context)
    {
        Timer(Duration(seconds: 3),()
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninScreen()),
          );
        });
    }
}