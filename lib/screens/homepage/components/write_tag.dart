import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_bloc.dart';
import 'package:mdk/utils/Constants.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../../bloc/HomepageBloc/homepage_event.dart';
import '../../../utils/configuration.dart';
class WriteTag extends StatefulWidget {
  const WriteTag({Key? key}) : super(key: key);

  @override
  State<WriteTag> createState() => _WriteTagState();
}

class _WriteTagState extends State<WriteTag> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
                         return ListView.builder(
                             itemCount: 2,
                             itemBuilder: (context,index)
                             {
                               return GestureDetector(
                                 onTap: (){
                                   context.read<HomePageBloc>().add(WriteDataEvent());
                                 },
                                 child: Container(
                                   decoration: const BoxDecoration(
                                       color: Color(0xffE9EBEC),
                                       borderRadius: BorderRadius.all(Radius.circular(10))
                                   ),


                             margin: EdgeInsets.fromLTRB(constraints.maxWidth*0.04, constraints.maxHeight*0.02, constraints.maxWidth*0.04,constraints.maxHeight*0.02),
                                   width: constraints.maxWidth,
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Row(
                                       children: [
                                         Image.asset(writeData[index]['image'],height: constraints.maxHeight*0.08,),
                                         const SizedBox(width: 20,),
                                         Text(writeData[index]['title'],style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily),)
                                       ],
                                     ),
                                   ),
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

  }

  Future<bool> _onWillPopCallback()async
  {
    context.read<HomePageBloc>().add(HomePageInitialEvent());
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
    path.quadraticBezierTo(0, size.height*2, factor, size.height);
    path.lineTo(size.width-factor, size.height);
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
