import 'package:flutter/material.dart';
class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(

        addAutomaticKeepAlives:false,
        addRepaintBoundaries:false,
        itemBuilder: (context,index)
        {
          return  const ExpansionTile(
            textColor: Color(0xffcb6e56),
            iconColor: Color(0xffcb6e56),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Answere'),
              )
            ],


            title: Padding(
              padding: EdgeInsets.all(20.0),
              child:Text('Questions')
              ,
            ),
          );

        },itemCount: 10,),
    );
  }
}
