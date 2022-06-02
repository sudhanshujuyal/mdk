import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:intl/intl.dart';
import 'package:mdk/utils/configuration.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import '../../../bloc/HomepageBloc/homepage_bloc.dart';
import '../../../bloc/HomepageBloc/homepage_event.dart';
import '../../../database/database_helper.dart';
import '../../../utils/Constants.dart';

class ReadTag extends StatefulWidget {
  const ReadTag({Key? key}) : super(key: key);

  @override
  State<ReadTag> createState() => _ReadTagState();
}

class _ReadTagState extends State<ReadTag> {
  bool showDialogBox = false;
  bool dataread = false;
  final GlobalKey<NavigatorState> key =
  GlobalKey<NavigatorState>();
  var data ="";
  var languagecode ="en";
  bool showopenbut = false;
  var type ="";
  var dialog = showDialog<void>;
  DatabaseHelper helper = DatabaseHelper.instance;
  DateTime dateTime = DateTime.now();
  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');
  ScanResult scanResult = ScanResult();
  final _aspectTolerance = 0.00;
  final _selectedCamera = -1;
  final _useAutoFocus = true;
  final _autoEnableFlash = true;
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);
  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  String selectedmethod = "";

  StreamSubscription<NDEFMessage>? _stream;

  void _startScanning(BuildContext con) {
      _stream = NFC.readNDEF(alertMessage: "Custom message with readNDEF#alertMessage").listen((NDEFMessage message) {
        if (message.isEmpty) {
          if(mounted)
            {
              setState(() {
                data = "";
                languagecode = "en";
                type = "";
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
                data = record.data.toString();
                if(record.languageCode != 'null'){
                  languagecode = record.languageCode;
                }else{
                  languagecode = "en";
                }
                type = record.type;
                type == 'T' ? showopenbut = false: showopenbut = true;
                String formattedDate = DateFormat('dd-MM-yyyy – HH:mm a').format(dateTime);
                Map<String, dynamic> row = {
                  DatabaseHelper.columnType : type == 'T'? "Plain/text": type == 'U'? "URL": type,
                  DatabaseHelper.columnMessage  : message.data.toString(),
                  DatabaseHelper.columnSize  : message.data.length,
                  DatabaseHelper.columnDate  : formattedDate,
                  DatabaseHelper.scanType  : "Read",
                };
                helper.insert(row);
                Navigator.pop(con);
                _stream?.cancel();
                dataread = true;
              });
            }
       /* print("Record '${record.id ?? "[NO ID]"}' with TNF '${record.tnf}', type "
              "'${record.type}', payload '${record.payload}' and data '${record.data}' and language code '${record.languageCode}'");*/
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      permissionformethod();
    });
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
                            child: Image.asset("assets/nfc.jpg",
                              height: constraints.maxHeight * 0.2,
                              width: constraints.maxWidth,
                              fit: BoxFit.cover,)),

                        Stack(
                          children: [
                            selectedmethod == "NFC Tap" ?
                            Container(
                              //padding: EdgeInsets.all(constraints.maxWidth * 0.04,),
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .16,
                                  right: 20.0,
                                  bottom: 20.0,
                                  left: 20.0),
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
                                      top: constraints.maxHeight * 0.02),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Data:  ", textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,),),
                                          Text(data != ""? data : "No data found", textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      dataread ? data.isNotEmpty ? Column(
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
                                      ): Container() : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ) :
                            Container(
                              //padding: EdgeInsets.all(constraints.maxWidth * 0.04,),
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .16,
                                  right: 20.0,
                                  bottom: 20.0,
                                  left: 20.0),
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
                                      top: constraints.maxHeight * 0.02),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Data:  ", textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,),),
                                          Text(data != ""? data : "No data found", textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      dataread ? data.isNotEmpty ? Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Language Code:  ", textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,),),
                                              Text(languagecode, textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(type == 'T'? "Plain/text": type == 'U'? "URL": type, textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,),),
                                              Text(" (${data.length} byte)", textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2),fontFamily: Constants.fontFamily,fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                        ],
                                      ): Container() : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: type == 'T' || type == ''? MainAxisAlignment.center: MainAxisAlignment.spaceEvenly,
                      children: [
                        Visibility(
                          visible: showopenbut,
                          child: GestureDetector(
                            onTap: (){
                              if(type == "SMS"){
                                sendtosms(data);
                              }else if(type == "U"){
                                launchurl(data);
                              }else if(type == "Email"){
                                opengmail(data);
                              }else if(type == "Contact"){
                                sendtocall(data);
                              }else if(type == "Location"){
                                launchMap(data);
                              }
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
                                    child: const Icon(Icons.exit_to_app_outlined),
                                  ),
                                ),
                                Text('Open',
                                  style: TextStyle(fontSize: ResponsiveFlutter.of(
                                      context).fontSize(1.5), fontFamily: Constants
                                      .fontFamily),)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            if(data.isNotEmpty){
                              Clipboard.setData(ClipboardData(text: data));
                              showsnacbar(context, "Copied");
                            }else {
                                showsnacbar(context, "No Data To Copy.");
                              }
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
                                  child: const Icon(Icons.copy),
                                ),
                              ),
                              Text('Copy',
                                style: TextStyle(fontSize: ResponsiveFlutter.of(
                                    context).fontSize(1.5), fontFamily: Constants
                                    .fontFamily),)
                            ],
                          ),
                        ),
                      ],
                    ),


                    // showDialog?showDialog(context: context, builder: (ctx) => MyAlertDialog()):Container()

                  ],
                ),
              );
            }),
      )
    );
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

  permissionformethod() {
    return dialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        _startScanning(context);
        return LayoutBuilder(
            builder: (context, constraints) {
              return  Center(
                child: Container(
                  margin: EdgeInsets.only(left: constraints.maxWidth*0.15,right: constraints.maxWidth*0.15),
                  height: constraints.maxHeight*0.2,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: constraints.maxHeight*0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: constraints.maxWidth*0.05),

                                child: Text('How you want to Read Data ?',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.3),color: Colors.black,decoration: TextDecoration.none,fontFamily: "JosefinSans"))),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right:constraints.maxWidth*0.05),
                          margin: EdgeInsets.only(top: constraints.maxHeight*0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                  setState(() {
                                    selectedmethod = "NFC Tap";
                                  });
                                  checkNfc();
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.black,width: 1)
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset("assets/nfc_device.png",height: 30,width: 30,),
                                        Container(
                                            margin: EdgeInsets.only(top: constraints.maxHeight*0.01),
                                            child: Text('NFC Tap',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.5),color: const Color(0xffD90068),decoration: TextDecoration.none,fontFamily:"JosefinSans"),textAlign: TextAlign.start,)),
                                      ],
                                    )),
                              ),
                              const Divider(),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                  setState(() {
                                    selectedmethod = "QR Code";
                                  });
                                  _scan();
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.black,width: 1)
                                    ),

                                    child: Column(
                                      children: [
                                        const Icon(FontAwesomeIcons.qrcode,size: 30,),
                                        Container(
                                            margin: EdgeInsets.only(top: constraints.maxHeight*0.01),
                                            child: Text('QR Code',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.5),color: const Color(0xffD90068),decoration: TextDecoration.none,fontFamily:"JosefinSans"),textAlign: TextAlign.start)),
                                      ],
                                    )),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      setState(() {
        scanResult = result;
        data = scanResult.rawContent;
        scanResult.rawContent.startsWith("http") ? type = "U" : type = "T";
        languagecode = "en";
        type == 'T' ? showopenbut = false: showopenbut = true;
        dataread = true;
      });
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }

}
