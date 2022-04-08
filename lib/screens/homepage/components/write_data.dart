
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';
import 'package:mdk/screens/homepage/components/write_detail.dart';
import 'package:mdk/utils/Constants.dart';
import 'package:mdk/utils/configuration.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
class WriteData extends StatefulWidget {
  const WriteData({Key? key}) : super(key: key);

  @override
  State<WriteData> createState() => _WriteDataState();
}

class _WriteDataState extends State<WriteData> {
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: _onWillPopCallback,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF3366FF),
                  Color(0xFF00CCFF),
                ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ClipPath(
                  clipper: CategoryCustomShape(),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40)

                        )
                    ),
                    margin: const EdgeInsets.only(top: 80),
                    height: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1.025,
                      child: Container(
                        decoration:const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10)

                            )
                        ),
                        child: LayoutBuilder(
                          builder: (context,constraints)
                          {
                            return GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                                itemCount: data.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return GestureDetector(
                                    onTap: (){

                                      context.read<HomePageBloc>().add(WriteDetailEvent(appTitle: data[index]['name']));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: constraints.maxWidth*0.01,right: constraints.maxWidth*0.01,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.01),
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

                                      alignment: Alignment.center,
                                      child: Text(data[index]['name'],style: TextStyle(color: Colors.white,fontFamily: Constants.fontFamily,fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),textAlign: TextAlign.center),
                                      // decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     borderRadius: BorderRadius.circular(15)),
                                    ),
                                  );
                                });
                          },
                        ),

                      ),
                    ),
                  ),
                ),
              )
            ],
          ) ,
        ),
      ),
    );
    // return WillPopScope(
    //   onWillPop: _onWillPopCallback,
    //   child: LayoutBuilder(
    //     builder: (context, constraints) {
    //       return  Scaffold(
    //         body:GridView.builder(
    //             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //                 maxCrossAxisExtent: 200,
    //                 childAspectRatio: 3 / 2,
    //                 crossAxisSpacing: 20,
    //                 mainAxisSpacing: 20),
    //             itemCount: data.length,
    //             itemBuilder: (BuildContext ctx, index) {
    //               return Container(
    //                 margin: EdgeInsets.only(left: constraints.maxWidth*0.01,right: constraints.maxWidth*0.01,top: constraints.maxHeight*0.01,bottom: constraints.maxHeight*0.01),
    //                 decoration: const BoxDecoration(
    //                   borderRadius: BorderRadius.all(
    //                       Radius.circular(10)),
    //                   gradient: LinearGradient(
    //                       colors: [
    //                         Color(0xFF3366FF),
    //                         Color(0xFF00CCFF),
    //                       ],
    //                       begin: FractionalOffset(0.0, 0.0),
    //                       end: FractionalOffset(1.0, 0.0),
    //                       stops: [0.0, 1.0],
    //                       tileMode: TileMode.clamp),
    //                 ),
    //
    //                 alignment: Alignment.center,
    //                 child: Text(data[index]['name'],style: TextStyle(color: Colors.white,fontFamily: Constants.fontFamily,fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),textAlign: TextAlign.center),
    //                 // decoration: BoxDecoration(
    //                 //     color: Colors.white,
    //                 //     borderRadius: BorderRadius.circular(15)),
    //               );
    //             }),
    //       );
    //     }),
    //   );
  }

  Future<bool> _onWillPopCallback() async
  {
    context.read<HomePageBloc>().add(WriteTagEvent());
    return false;
  }
}
class CategoryCustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    var roundnessFactor = 50.0;

    // var path = Path();

    double factor = 20.0;
    path.lineTo(0, size.height - factor);
    path.quadraticBezierTo(0, size.height * 2, factor, size.height);
    path.lineTo(size.width - factor, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(factor, 0);
    path.quadraticBezierTo(0, 0, 0, factor);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
