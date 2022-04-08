import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_bloc.dart';

import '../../../bloc/HomepageBloc/homepage_event.dart';
class WriteDetail extends StatefulWidget
{
 final String? appTitle;
  const WriteDetail({Key? key,this.appTitle}) : super(key: key);

  @override
  State<WriteDetail> createState() => _WriteDetailState();
}

class _WriteDetailState extends State<WriteDetail> {
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
        body: Text('Write Detail'),

      ),
          ),
    );
  }

  Future<bool> _onWillPopCallBack() async
  {
    context.read<HomePageBloc>().add(WriteDataEvent());
    return false;
  }
}
