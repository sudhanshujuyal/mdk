import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
class ActivateTag extends StatefulWidget {
  const ActivateTag({Key? key}) : super(key: key);

  @override
  State<ActivateTag> createState() => _ActivateTagState();
}

class _ActivateTagState extends State<ActivateTag> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints)
      {
        return Scaffold(
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: constraints.maxHeight*0.03),
                  width: constraints.maxWidth,

                    child: Text('Tapitek tags',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                Container(
                    margin: EdgeInsets.only(top: constraints.maxHeight*0.03),
                    width: constraints.maxWidth,

                    child: Text('There are no tags connected to your profile. \n Connect one now!',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.8),fontWeight: FontWeight.w400),textAlign: TextAlign.center,)),

              GestureDetector(
                  onTap: (){
                    __showSettingDialog(constraints,context);

                  },
                  child: Image.asset("assets/circular_loading.png",height: constraints.maxHeight*0.20,width: constraints.maxWidth*0.24,)),
                GestureDetector(
                    onTap: (){
                    },
                    child: Text('Activate Tag',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.7)),))

              ],
            )
        );
      },
    );

  }

  __showSettingDialog(BoxConstraints constraints, BuildContext context) {

    return showModalBottomSheet<void>(
      backgroundColor: const Color(0xfff1f1f1),
      // context and builder are
      // required properties in this widget
      context: context,
      builder: (context1) {
        // we set up a container inside which
        // we create center column and display text

        return Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: constraints.maxWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                            margin: EdgeInsets.only(top: constraints.maxHeight*0.06),
                            child:const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.document_scanner_outlined,color: Colors.black,size: 120,),
                            )
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),)
                  ],
                ),

              ),
            ),


            GestureDetector(
              onTap: (){
                // __showChangeUsernameDialog(constraints,context);
                // const snackBar = SnackBar(
                //   content: Text('Copied to clipboard'),
                // );
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: EdgeInsets.only(top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                    child: Container(
                        child: Text('Scan Qr Code',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),textAlign: TextAlign.center,)
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: constraints.maxWidth*0.15,right: constraints.maxWidth*0.15,top: constraints.maxHeight*0.05),
              child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 10.0,
                  shadowColor: Colors.black,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        hintText: 'Activation Code',
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 3),
                        ),
                        labelStyle: const TextStyle(color: Colors.black)),
                  )
              ),
            ),
            const SizedBox(height: 10,),

            Text('Enter the activation code',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),textAlign: TextAlign.center,),
            const SizedBox(height: 20,),

            GestureDetector(
              onTap: (){
                // __showChangePasswordDialog(constraints,context);
                // __showChangePasswordDialog(constraints,context);

                // const snackBar = SnackBar(
                //   content: Text('Copied to clipboard'),
                // );
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Container(
                margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.01),
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                      child: Text('Activate tag',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    )
                  ],
                ),

              ),
            ),



          ],
        );
      },
    );
  }
}
