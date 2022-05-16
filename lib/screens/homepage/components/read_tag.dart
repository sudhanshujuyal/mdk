import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import '../../../utils/Constants.dart';

class ReadTag extends StatefulWidget {
  const ReadTag({Key? key}) : super(key: key);

  @override
  State<ReadTag> createState() => _ReadTagState();
}

class _ReadTagState extends State<ReadTag> {
  bool showDialogBox = false;
  final GlobalKey<NavigatorState> key =
  GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: LayoutBuilder(
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
                          child: Container(
                            height: constraints.maxHeight*0.20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF3366FF),
                                    Color(0xFF00CCFF),
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: Text(''),
                          )
                      ),

                      Stack(
                        children: [

                          Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(
                                top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .14,
                                right: 20.0,
                                left: 20.0),
                            child: Container(
                              // height: constraints.maxHeight*0.12,
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('No data found',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.5),fontFamily: Constants.fontFamily,fontWeight: FontWeight.bold),),
                                      Container(
                                        margin: EdgeInsets.only(top:constraints.maxHeight*0.04),
                                        // width: constraints.maxWidth,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffe5F3ff)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.fromLTRB(
                                                        constraints.maxWidth * 0.04,
                                                        constraints.maxHeight * 0.02,
                                                        constraints.maxWidth * 0.04,
                                                        constraints.maxHeight * 0.02),
                                                    child: const Icon(Icons.share_outlined,color: Color(0xff0047aa),),
                                                  ),
                                                  Text('Share',
                                                    style: TextStyle(fontSize: ResponsiveFlutter.of(
                                                        context).fontSize(1.5), fontFamily: Constants
                                                        .fontFamily),)
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      constraints.maxWidth * 0.04,
                                                      constraints.maxHeight * 0.02,
                                                      constraints.maxWidth * 0.04,
                                                      constraints.maxHeight * 0.02),
                                                  child: const Icon(Icons.content_copy_outlined, color: Color(0xff0047aa),),
                                                ),
                                                Text('Copy',
                                                  style: TextStyle(fontSize: ResponsiveFlutter.of(
                                                      context).fontSize(1.5), fontFamily: Constants
                                                      .fontFamily),)
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      constraints.maxWidth * 0.04,
                                                      constraints.maxHeight * 0.02,
                                                      constraints.maxWidth * 0.04,
                                                      constraints.maxHeight * 0.02),
                                                  child: const Icon(Icons.settings_outlined,color: Color(0xff0047aa),),
                                                ),
                                                Text('Setting',
                                                  style: TextStyle(fontSize: ResponsiveFlutter.of(
                                                      context).fontSize(1.5), fontFamily: Constants
                                                      .fontFamily),)
                                              ],
                                            ),



                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

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


                                ],
                              ),

                            ),
                          ),
                          // Row(
                          //   children: [
                          //

                          //
                          //   ],
                          // )


                        ],
                      )
                    ],
                  ),



                  // showDialog?showDialog(context: context, builder: (ctx) => MyAlertDialog()):Container()

                ],
              ),
            );
          }),
    );
  }


  _showStartDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return LayoutBuilder(
            builder: (context, constraints) {
              return  Center(
                child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffE0F0F9),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(

                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.asset("assets/nfc_device.png",height: constraints.maxHeight*0.18,width: constraints.maxWidth*2.05,),
                                ),

                                Text('NFC NOT AVAILABLE',style: TextStyle(color: Colors.black,fontSize: ResponsiveFlutter.of(context).fontSize(2.0),fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text('Your device does not support NFC tags',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.4)),),
                                Divider(color: Colors.white,)
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: constraints.maxWidth*0.04,right: constraints.maxWidth*0.04,top: constraints.maxHeight*0.01,bottom: constraints.maxHeight*0.01),
                              width: constraints.maxWidth,
                              child: Text('Ok, got it',textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.8),fontWeight: FontWeight.bold),),
                            ),
                          )
                        ],
                      ),
                    )
                ),
              );
            });

      },
    );
  }



}
