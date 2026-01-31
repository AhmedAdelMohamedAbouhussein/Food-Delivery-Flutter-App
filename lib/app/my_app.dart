import 'package:final_proj/features/home/homeLogic/home_cubit.dart';
import 'package:final_proj/features/home/paymentLogic/payment_cubit.dart';
import 'package:final_proj/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_proj/core/resources/app_colors.dart';
import 'package:final_proj/core/resources/app_router.dart';
import 'package:final_proj/core/storage/sharedPrefsHelper.dart';
import 'package:final_proj/features/home/signin_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPrefsHelper? _prefsHelper;
  bool _loading = true;
  Widget _initialScreen = const SigninScreen();

  @override
  void initState() {
    super.initState();
    _checkPhoneNumber();
  }

  Future<void> _checkPhoneNumber() async {
    _prefsHelper = await SharedPrefsHelper.init();
    if (_prefsHelper!.phoneNumber != null && _prefsHelper!.phoneNumber!.isNotEmpty) {
      _initialScreen = const SplashScreen();
    } else {
      _initialScreen = const SplashScreen();
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    // Use MultiBlocProvider to provide multiple Cubits at once
    return MultiBlocProvider(
      providers: [
        BlocProvider<PaymentCubit>(
          create: (context) => PaymentCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.globalDarkMode),
        home: _initialScreen,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}