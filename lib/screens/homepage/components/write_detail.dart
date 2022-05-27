import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_bloc.dart';
import 'package:mdk/database/database_helper.dart';
import 'package:mdk/utils/Constants.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../../bloc/HomepageBloc/homepage_event.dart';

class RecordEditor {
  final TextEditingController writeTagController = TextEditingController();
}

class WriteDetail extends StatefulWidget
{
 final String? appTitle;
  const WriteDetail({Key? key,this.appTitle}) : super(key: key);

  @override
  State<WriteDetail> createState() => _WriteDetailState();
}

class _WriteDetailState extends State<WriteDetail>
{
  StreamSubscription<NDEFMessage>? _stream;
  List<RecordEditor> _records = [];
  bool _hasClosedWriteDialog = false;
  DatabaseHelper helper = DatabaseHelper.instance;
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          WillPopScope(
            onWillPop: _onWillPopCallBack,
            child: Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle!),
      ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: constraints.maxWidth*0.04,right: constraints.maxWidth*0.04,top: constraints.maxHeight*0.04),

                  child: Text('Please Enter '+widget.appTitle.toString(),style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.8),fontFamily: Constants.fontFamily),textAlign: TextAlign.start,)),


              for(var record in _records)
              Container(
                margin: EdgeInsets.only(left: constraints.maxWidth*0.04,right: constraints.maxWidth*0.04,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.04),
                child: TextFormField(
                  controller: record.writeTagController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      // fillColor: Colors.black.withOpacity(0.2),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            // style: BorderStyle.solid,
                            width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            // style: BorderStyle.solid,
                            width: 2),
                      ),
                      labelStyle: const TextStyle(color: Colors.black)),
                ),
              ),

              GestureDetector(
                onTap: _records.isNotEmpty ? () => _write(context) : null,
                // onTap: (){
                //   print('length is'+_records.length.toString());
                //   _records.length > 0 ? () => _write(context) : null;
                // },
                child: Container(
                  margin: EdgeInsets.only(left: constraints.maxWidth*0.04,right: constraints.maxWidth*0.04),
                  width: constraints.maxWidth,
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:  Text('Write Record',style: TextStyle(color: Colors.white,fontSize: ResponsiveFlutter.of(context).fontSize(1.8),fontFamily: Constants.fontFamily),textAlign: TextAlign.center,),
                  ),

                ),
              ),

            ],
          ),
        ),

      ),
          ),
    );
  }

  @override
  void initState() {
    _addRecord();
  }

  Future<bool> _onWillPopCallBack() async
  {
    context.read<HomePageBloc>().add(WriteDataEvent());
    return false;
  }

  void _write(BuildContext context) async
  {
    print('inside write');
    List<NDEFRecord?> records = _records.map((record) {
      if(widget.appTitle == "Plain/text"){
        return NDEFRecord.text(
          record.writeTagController.text, languageCode: "en",
        );
      }
      if(widget.appTitle == "URL") {
        return NDEFRecord.uri(Uri.parse(record.writeTagController.text));
      }
      if(widget.appTitle == "SMS"){
        return NDEFRecord.type(
          widget.appTitle,record.writeTagController.text
        );
      }
      if(widget.appTitle == "Email") {
        return NDEFRecord.type(
            widget.appTitle,record.writeTagController.text
        );
      }
      if(widget.appTitle == "Contact") {
        return NDEFRecord.type(
            widget.appTitle,record.writeTagController.text
        );
      }
      if(widget.appTitle == "Location") {
        return NDEFRecord.type(
            widget.appTitle,record.writeTagController.text
        );
      }
    }).toList();

    NDEFMessage message = NDEFMessage.withRecords(records);

    // Show dialog on Android (iOS has it's own one)
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

    // Write to the first tag scanned
    await NFC.writeNDEF(message).first;
    if (!_hasClosedWriteDialog) {
      Navigator.pop(context);
    }
    String formattedDate = DateFormat('dd-MM-yyyy – HH:mm a').format(dateTime);
    Map<String, dynamic> row = {
      DatabaseHelper.columnType : widget.appTitle,
      DatabaseHelper.columnMessage  : message.data.toString(),
      DatabaseHelper.columnSize  : message.data.length,
      DatabaseHelper.columnDate  : formattedDate,
      DatabaseHelper.scanType  : "Write",
    };
    helper.insert(row).then((value) => context.read<HomePageBloc>().add(HomePageInitialEvent()));
  }

  void _addRecord()
  {
    setState(() {
      _records.add(RecordEditor());
    });
  }
}
