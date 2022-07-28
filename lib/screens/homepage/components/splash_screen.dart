import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';
import 'package:mdk/screens/homepage/components/verify_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/authenticationBloc/authentication_bloc.dart';
import '../../../bloc/authenticationBloc/authentication_event.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Center(
        child: Image.asset("assets/logo.png"),
      ),
    );
  }

  Future<void> checkVerify() async {
    final prefs = await SharedPreferences.getInstance();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if(mounted){
        if(prefs.getBool("Login")?? false){
          context.read<AuthenticationBloc>().add(AuthenticationHomepageEvent());

        }else if(prefs.getBool("Verify")?? false){
          context.read<AuthenticationBloc>().add(AuthenticationLoginEvent());
        }
        else{
          context.read<AuthenticationBloc>().add(AuthenticationVerifyTokenEvent());
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkVerify();
  }
}
