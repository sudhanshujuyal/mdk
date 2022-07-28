import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/Constants.dart';
import '../../widgets/my_clipper.dart';

class HomePageInitial extends StatefulWidget {
  const HomePageInitial({Key? key}) : super(key: key);

  @override
  State<HomePageInitial> createState() => _HomePageInitialState();
}

class _HomePageInitialState extends State<HomePageInitial> {
  bool showDialogBox = false;
  bool _isCollapsed = false;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
          body: Stack(
            children: [
              LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: <Widget>[
                              // The containers in the background
                              Container(
                                  width: constraints.maxWidth,
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
                                    height: constraints.maxHeight * 0.2,
                                    width: constraints.maxWidth,
                                    fit: BoxFit.cover,)),

                              Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.only(
                                        top: MediaQuery
                                            .of(context)
                                            .size
                                            .height * .16,
                                        right: 20.0,
                                        left: 20.0),
                                    child: SizedBox(
                                      height: orientation == Orientation.portrait ? constraints.maxHeight * 0.08 : constraints.maxHeight * 0.15,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 4.0,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: constraints.maxWidth * 0.04,
                                              top: constraints.maxHeight * 0.02),

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                    // margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxHeight*0.09),

                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.only(
                                        top: MediaQuery
                                            .of(context)
                                            .size
                                            .height * .19,
                                        right: 20.0,
                                        left: 20.0),
                                    child: Container(
                                      height: 100.0,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: (){
                                                print('show dialog box'+showDialogBox.toString());
                                                context.read<HomePageBloc>().add(
                                                    ReadTagEvent());
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: constraints.maxHeight * 0.03,
                                                    right: constraints.maxWidth * 0.05,
                                                    left: constraints.maxWidth * 0.05),
                                                padding: EdgeInsets.fromLTRB(
                                                    constraints.maxWidth * 0.02,
                                                    constraints.maxHeight * 0.02,
                                                    constraints.maxWidth * 0.02,
                                                    constraints.maxHeight * 0.02),
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFF3366FF),
                                                        Color(0xFF00CCFF),
                                                      ],
                                                      begin: FractionalOffset(0.0, 0.0),
                                                      end: FractionalOffset(1.0, 0.0),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceAround,
                                                  children: [
                                                    const Icon(
                                                      Icons.library_books_outlined,
                                                      color: Colors.white,),
                                                    Text('Read Tags',
                                                      style: TextStyle(
                                                          fontSize: ResponsiveFlutter.of(
                                                              context).fontSize(1.4),
                                                          fontFamily: Constants.fontFamily,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold),)
                                                    // Text('d')
                                                  ],
                                                ),
                                                // margin: EdgeInsets.only(left: constraints.maxWidth*0.08,top: constraints.maxHeight*0.08),

                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                print('show dialog write box'+showDialogBox.toString());

                                                showDialogBox? _showStartDialog()
                                                    : context.read<HomePageBloc>().add(
                                                    WriteTagEvent());
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: constraints.maxHeight *
                                                        0.03,
                                                    right: constraints.maxWidth * 0.05,
                                                    left: constraints.maxWidth * 0.05),


                                                padding: EdgeInsets.fromLTRB(
                                                    constraints.maxWidth * 0.02,
                                                    constraints.maxHeight * 0.02,
                                                    constraints.maxWidth * 0.02,
                                                    constraints.maxHeight * 0.02),
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFF3366FF),
                                                        Color(0xFF00CCFF),
                                                      ],
                                                      begin: FractionalOffset(0.0, 0.0),
                                                      end: FractionalOffset(1.0, 0.0),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceAround,

                                                  children: [
                                                    const Icon(Icons.create_outlined,
                                                      color: Colors.white,),
                                                    Text('Write Tags', style: TextStyle(
                                                        fontSize: ResponsiveFlutter.of(
                                                            context).fontSize(1.4),
                                                        fontFamily: Constants
                                                            .fontFamily,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold),)
                                                    // Text('d')
                                                  ],
                                                ),
                                                // margin: EdgeInsets.only(left: constraints.maxWidth*0.08,top: constraints.maxHeight*0.08),

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ),
                                  ),


                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  context.read<HomePageBloc>().add(EraseEvent());
                                },
                                child: Column(
                                  children: [
                                    Card(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            constraints.maxWidth * 0.04,
                                            constraints.maxHeight * 0.02,
                                            constraints.maxWidth * 0.04,
                                            constraints.maxHeight * 0.02),
                                        child: const Icon(FontAwesomeIcons.eraser),
                                      ),
                                    ),
                                    Text('Erase  Tag',
                                      style: TextStyle(fontSize: ResponsiveFlutter.of(
                                          context).fontSize(1.5), fontFamily: Constants
                                          .fontFamily),)
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  context.read<HomePageBloc>().add(HistoryEvent());
                                },
                                child: Column(
                                  children: [
                                    Card(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            constraints.maxWidth * 0.04,
                                            constraints.maxHeight * 0.02,
                                            constraints.maxWidth * 0.04,
                                            constraints.maxHeight * 0.02),
                                        child: const Icon(FontAwesomeIcons.history),
                                      ),
                                    ),
                                    Text('History',
                                      style: TextStyle(fontSize: ResponsiveFlutter.of(
                                          context).fontSize(1.5), fontFamily: Constants
                                          .fontFamily),)
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  context.read<HomePageBloc>().add(AppInfoEvent());
                                },
                                child: Column(
                                  children: [
                                    Card(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            constraints.maxWidth * 0.04,
                                            constraints.maxHeight * 0.02,
                                            constraints.maxWidth * 0.04,
                                            constraints.maxHeight * 0.02),
                                        child: const Icon(FontAwesomeIcons.info),
                                      ),
                                    ),
                                    Text('App Info',
                                      style: TextStyle(fontSize: ResponsiveFlutter.of(
                                          context).fontSize(1.5), fontFamily: Constants
                                          .fontFamily),)
                                  ],
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () async {
                              //     final prefs = await SharedPreferences.getInstance();
                              //     var loginType = prefs.getString("LoginType");
                              //     if(loginType == "Facebook"){
                              //       prefs.clear();
                              //     }else if(loginType == "Google"){
                              //       prefs.clear();
                              //     }else{
                              //       prefs.clear();
                              //     }
                              //     context.read<HomePageBloc>().add(LoginEvent());
                              //   },
                              //   child: Column(
                              //     children: [
                              //       Card(
                              //         child: Padding(
                              //           padding: EdgeInsets.fromLTRB(
                              //               constraints.maxWidth * 0.04,
                              //               constraints.maxHeight * 0.02,
                              //               constraints.maxWidth * 0.04,
                              //               constraints.maxHeight * 0.02),
                              //           child: const Icon(Icons.logout),
                              //         ),
                              //       ),
                              //       Text('LogOut',
                              //         style: TextStyle(fontSize: ResponsiveFlutter.of(
                              //             context).fontSize(1.5), fontFamily: Constants
                              //             .fontFamily),)
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: _isCollapsed ? -120 : size.width - 65,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: size.height,
                        width: size.width + 90,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Color(0xffccbf90),
                            Color(0xffccbf90),
                          ],
                        )),
                        child: const Text('sadasd'),
                      ),
                    ),
                    Positioned(
                        left: 8,
                        top: size.height * 0.65 + 37,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isCollapsed = !_isCollapsed;
                            });
                          },
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black.withOpacity(0.8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Center(
                              child: Text('safa'),
                              // child: SvgPicture.asset(
                              //   Constants.qrSvg,
                              //   color: Colors.white,
                              //   height: 20,
                              // ),
                            ),
                          ),
                        )),
                    Positioned(
                      right: 7,
                      top: size.height * 0.65 + 37,
                      child: GestureDetector(
                        onTap: () => setState(() {
                          _isCollapsed = !_isCollapsed;
                        }),
                        child: Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blue,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            // child: SvgPicture.asset(
                            //   Constants.qrSvg,
                            //   color: Colors.white,
                            //   height: 26,
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ));
    });
  }

  @override
  void initState() {
    super.initState();
    checkNfc();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await showDialog<String>(
    //       context: context,
    //       builder: (BuildContext context) => new ;
    //   );
    // });
  }

  _showStartDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return LayoutBuilder(builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
                child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffE0F0F9),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(
                  left: constraints.maxWidth * 0.05,
                  right: constraints.maxWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            "assets/nfc_device.png",
                            height: constraints.maxHeight * 0.18,
                            width: constraints.maxWidth * 2.05,
                          ),
                        ),
                        Text(
                          'NFC NOT AVAILABLE',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.0),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Your device does not support NFC tags',
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(1.4)),
                        ),
                        Divider(
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: constraints.maxWidth * 0.04,
                          right: constraints.maxWidth * 0.04,
                          top: constraints.maxHeight * 0.01,
                          bottom: constraints.maxHeight * 0.01),
                      width: constraints.maxWidth,
                      child: Text(
                        'Ok, got it',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(1.8),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            )),
          );
        });
      },
    );
  }

  void checkNfc() async {
    var availability = await FlutterNfcKit.nfcAvailability;
    print('availablity name' + availability.name);
    if (availability.name == "not_supported") {
      showDialogBox = true;
      _showStartDialog();
    } else if (availability.name == "disabled") {}
    print('isAvailable' + availability.toString());
  }
}
