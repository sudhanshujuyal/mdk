import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mdk/screens/homepage/components/write_detail.dart';
import 'package:mdk/utils/configuration.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import '../../../bloc/HomepageBloc/homepage_bloc.dart';
import '../../../bloc/HomepageBloc/homepage_event.dart';
import '../../../database/database_helper.dart';
import '../../../utils/Constants.dart';

class EraseTag extends StatefulWidget {
  const EraseTag({Key? key}) : super(key: key);

  @override
  State<EraseTag> createState() => EraseTagState();
}

class EraseTagState extends State<EraseTag> {
  bool showDialogBox = false;
  bool dataread = false;
  final GlobalKey<NavigatorState> key =
  GlobalKey<NavigatorState>();
  List<RecordEditor> _records = [];
  var data ="";
  var languagecode ="en";
  var type ="";
  var dialog = showDialog<void>;
  DatabaseHelper helper = DatabaseHelper.instance;
  DateTime dateTime = DateTime.now();
  bool _hasClosedWriteDialog = false;
  StreamSubscription<NDEFMessage>? _stream;

  void _startScanning(BuildContext con) {
    _stream = NFC.readNDEF(alertMessage: "Custom message with readNDEF#alertMessage").listen((NDEFMessage message) {
      if (message.isEmpty) {
        if(mounted)
        {
          setState(() {
            data = "";
            languagecode = "en";
            type = "text";
            Navigator.pop(con);
            _stream?.cancel();
            dataread = true;
          });
        }

        return;
      }
      /* print("Read NDEF message with ${message.records.length} records");
        readdialogbox = false;*/

      for (NDEFRecord record in message.records)
      {
        if(mounted)
        {
          setState(() {
            dataread = false;
            data = record.data.toString();
            if(record.languageCode != 'null'){
              languagecode = record.languageCode;
            }else{
              languagecode = "en";
            }
            type = record.type;
            Navigator.pop(con);
            _stream?.cancel();
            dataread = true;
          });
        }
         print("Record '${record.id ?? "[NO ID]"}' with TNF '${record.tnf}', type "
              "'${record.type}', payload '${record.payload}' and data '${record.data}' and language code '${record.languageCode}'");
      }
    }, onError: (error) {
      if(mounted)
      {
        setState(() {
          _stream = null;
          dataread = true;
          Navigator.pop(con);
          _stream?.cancel();
        });
      }

      if (error is NFCUserCanceledSessionException)
      {
        if(mounted)
        {
          setState(() {
            showsnacbar(context, "user canceled");
            dataread = true;
            Navigator.pop(con);
            _stream?.cancel();
          });
        }

      } else if (error is NFCSessionTimeoutException)
      {
        if(mounted)
        {
          setState(() {
            showsnacbar(context, "session timed out");
            dataread = true;
            Navigator.pop(con);
            _stream?.cancel();
          });
        }

      } else {
        if(mounted)
        {
          setState(() {
            showsnacbar(context, error.toString());
            dataread = true;
            Navigator.pop(con);
            _stream?.cancel();
          });
        }

      }
    }, onDone: () {
      if(mounted)
      {
        setState(() {
          _stream = null;
          dataread = true;
          Navigator.pop(con);
          _stream?.cancel();
        });
      }

    });
  }

  void _stopScanning() {
    _stream?.cancel();
    setState(() {
      _stream = null;
    });
  }

  void _toggleScan() {
    if (_stream == null) {
      openloaddialog();
    } else {
      _stopScanning();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkNfc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _stream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPopCallback,
        child:Scaffold(
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
                                child: const Text(''),
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
                                    bottom: 20.0,
                                    left: 20.0),
                                child: SizedBox(
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
                                          bottom: constraints.maxWidth * 0.04,
                                          right: constraints.maxWidth * 0.04,
                                          top: constraints.maxHeight * 0.02),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("text:  ", textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,),),
                                              Text(data != ""? data : "No data found", textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                          dataread ? Column(
                                            children: [
                                              type == "T"?
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Language Code:  ", textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,),),
                                                  Text(languagecode, textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,fontWeight: FontWeight.bold),),
                                                ],
                                              ): Container(),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(type == 'T'? "Plain/text": type == 'U'? "URL": type, textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,),),
                                                  Text(" (${data.length} byte)", textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            ],
                                          ): Container(),

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
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.only(
                                    top: MediaQuery
                                        .of(context)
                                        .size
                                        .height * .19,
                                    right: 20.0,
                                    left: 20.0),
                                child: SizedBox(
                                  height: 100.0,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: const [


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

                    ],
                  ),
                );
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () => erasetag(),
            child: const Icon(FontAwesomeIcons.eraser),
          ),
        )
    );
  }

  void erasetag() async
  {
    print('inside erase');
    NDEFRecord record = NDEFRecord.empty();

    NDEFMessage message = NDEFMessage.withRecords([record]);

    // Show dialog on Android (iOS has it's own one)
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Scan the tag you want to write to"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                _hasClosedWriteDialog = true;
                _stream?.cancel();
                Navigator.pop(context);
                print('hekko');
              },
            ),
          ],
        ),
      );
    }

    // Write to the first tag scanned
    await NFC.writeNDEF(message).first;
    if (!_hasClosedWriteDialog) {
      Navigator.pop(context);
    }
    context.read<HomePageBloc>().add(HomePageInitialEvent());
  }

  Future<bool> _onWillPopCallback()async
  {
    context.read<HomePageBloc>().add(HomePageInitialEvent());
    return false;
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
                          color: const Color(0xffE0F0F9),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset("assets/nfc_device.png",height: constraints.maxHeight*0.18,width: constraints.maxWidth*2.05,),
                              ),

                              Text('NFC NOT AVAILABLE',style: TextStyle(color: Colors.black,fontSize: ResponsiveFlutter.of(context).fontSize(2.0),fontWeight: FontWeight.bold),),
                              const SizedBox(height: 10,),
                              Text('Your device does not support NFC tags',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.4)),),
                              const Divider(color: Colors.white,)
                            ],
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

  openloaddialog() {
    return dialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        _startScanning(context);
        return LayoutBuilder(
            builder: (context, constraints) {
              return  Center(
                child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffE0F0F9),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset("assets/nfc_device.png",height: constraints.maxHeight*0.18,width: constraints.maxWidth*2.05,),
                              ),

                              Text('Scan the tag you want to write to',style: TextStyle(color: Colors.black,fontSize: ResponsiveFlutter.of(context).fontSize(2.0),fontWeight: FontWeight.bold),),
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Text('Please tap your NFC compatible TAG properly on back of your device.', textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.4)),),
                              ),
                              const Divider(color: Colors.white,)
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              _stream?.cancel();
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: constraints.maxWidth*0.04,right: constraints.maxWidth*0.04,top: constraints.maxHeight*0.01,bottom: constraints.maxHeight*0.01),
                              width: constraints.maxWidth,
                              child: Text('Cancel',textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.8),fontWeight: FontWeight.bold),),
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

  void checkNfc()async {
    var availability = await FlutterNfcKit.nfcAvailability;
    print('availablity name'+availability.name);
    if(availability.name=="not_supported")
    {
      showDialogBox=true;
      _showStartDialog();
    }else{
      print('_toggleScan');
      _toggleScan();
    }
    print('isAvailable'+availability.toString());
  }

}
