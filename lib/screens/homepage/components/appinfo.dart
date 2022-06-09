

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/utils/configuration.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import '../../../bloc/HomepageBloc/homepage_bloc.dart';
import '../../../bloc/HomepageBloc/homepage_event.dart';
import '../../../utils/Constants.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({Key? key}) : super(key: key);

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPopCallback,
        child:Scaffold(
          key: key,
          body: Stack(
          children: <Widget>[
          // The containers in the background
          Container(
          width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Image.asset("assets/nfc.jpg",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,),
          ),
      Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .16,
              right: 20.0,
              bottom: 20.0,
              left: 20.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.white,
              elevation: 4.0,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: aboutus.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                          //top: constraints.maxWidth * 0.04,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(aboutus[index]['name'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontFamily: Constants.fontFamily,fontSize: ResponsiveFlutter.of(context).fontSize(2))),
                            const SizedBox(height: 10,),
                            Text(aboutus[index]['value'],style: TextStyle(color: Colors.black,fontFamily: Constants.fontFamily,fontSize: ResponsiveFlutter.of(context).fontSize(2))),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ),
      ),
      ],
    ),
    )
    );
  }

  Future<bool> _onWillPopCallback()async
  {
    context.read<HomePageBloc>().add(HomePageInitialEvent());
    return false;
  }

}
