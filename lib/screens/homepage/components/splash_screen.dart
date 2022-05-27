import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Image.asset("assets/logo.png"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      context.read<HomePageBloc>().add(VerifyTokenEvent());
    });
  }
}