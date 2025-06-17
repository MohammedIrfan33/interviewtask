import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/constance/color_constant.dart';
import 'package:task/view_model/globle_view_model.dart';

class SplashRedirectorScreen extends StatefulWidget {
  const SplashRedirectorScreen({super.key});

  @override
  State<SplashRedirectorScreen> createState() => _SplashRedirectorScreenState();
}

class _SplashRedirectorScreenState extends State<SplashRedirectorScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<GlobalViewModel>(context, listen: false).checkLoginStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:  kPrimaryColor,
      body: Center(child: CircularProgressIndicator(color: Colors.white,)),
    );
  }
}
