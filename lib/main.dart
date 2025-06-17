import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task/view/splash_screen.dart';
import 'package:task/view_model/globle_view_model.dart';
import 'package:task/view_model/home_view_model.dart';
import 'package:task/view_model/root_view_model.dart';
import 'package:task/view_model/auth_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => RootViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        title: 'Reseller',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'sfpro'),

        home: SplashRedirectorScreen(),
      ),
    );
  }
}
