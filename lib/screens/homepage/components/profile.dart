import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';
import 'package:mdk/bloc/profileBloc/profile_bloc.dart';
import 'package:mdk/screens/homepage/home_page.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../../bloc/HomepageBloc/homepage_bloc.dart';
import '../../../bloc/profileBloc/profile_event.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback? _showPersistentBottomSheetCallBack;
  String editProfile="Edit Profile";
  bool onTapping=false;

  void initState() {
    super.initState();
    _showPersistentBottomSheetCallBack = _showBottomSheet;
  }

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
      builder: (context,constraints)
      {
       return Scaffold(
           backgroundColor: Colors.transparent,

         resizeToAvoidBottomInset: false,
            body: Container(
              width: constraints.maxWidth,
              margin: EdgeInsets.only(left: constraints.maxWidth*0.03,top: constraints.maxWidth*0.01),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: constraints.maxWidth*0.3,
                        height: constraints.maxHeight*0.3,
                          decoration:BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.5)
                          ),
                        child: Center(child: Icon(Icons.person,size: constraints.maxHeight*0.1,color: Colors.blue,)),
                      ),
                      onTapping?Container():Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: constraints.maxWidth,
                              // color: Colors.black,
                              margin: EdgeInsets.only(left: constraints.maxWidth*0.04,right: constraints.maxWidth*0.04),
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10.0,
                                shadowColor: Colors.black,
                                child: TextFormField(
                                  // onChanged: (email)=>context.read<SignUpBloc>().add(SignUpEmailChanged(email:email)),

                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      hintText: 'Name',
                                      hintStyle: const TextStyle(fontWeight: FontWeight.bold),

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
                                ),

                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              width: constraints.maxWidth,
                              // color: Colors.black,
                              margin: EdgeInsets.only(left: constraints.maxWidth*0.04,right: constraints.maxWidth*0.04),
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10.0,
                                shadowColor: Colors.black,
                                child: TextFormField(
                                  // onChanged: (email)=>context.read<SignUpBloc>().add(SignUpEmailChanged(email:email)),

                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      hintText: 'Write something about you and your brand',

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
                                ),

                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        if(mounted)
                        {
                          onTapping=!onTapping;
                          if(onTapping)
                            {
                              editProfile="Edit Profile";
                            }
                          else
                            {
                              editProfile="Profile Preview ";

                            }

                        }
                      });

                    },
                    child: Container(
                      width: constraints.maxWidth*0.8,
                        margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow:const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(2.0, 2.0,), // shadow direction: bottom right
                            )
                          ],
                        ),
                      child: Padding(
                        padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                        child:  Text(editProfile,textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  onTapping?Container():Material(
                    elevation: 8,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      margin: EdgeInsets.only(top: constraints.maxHeight*0.01,left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05),

                      width: constraints.maxWidth*0.8,
                      child: Column(
                        children: [
                          Container(
                              margin:EdgeInsets.only(top: constraints.maxHeight*0.02),
                              child: Text('There are no links in your profile',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),fontWeight: FontWeight.bold),)),
                          const SizedBox(height: 20,),
                          GestureDetector(
                            onTap: (){
                              context.read<ProfileBloc>().add(AddLinkClicked());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow:const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(2.0, 2.0,), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left:constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.03,bottom: constraints.maxHeight*0.03),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                          Container(
                              margin:EdgeInsets.only(top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                              child: Text('Add link',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),)),
                        ],
                      ),
                    ),
                  )


                ],
              ),
            )
        );
      },
    );
  }
  void _showBottomSheet() {
    setState(() {
      _showPersistentBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState!
        .showBottomSheet(
          (context) {
        // EN: Here you set up your BottomSheet with the widgets you want, on it you'll use the SnackBar.
        // PT-BR: Aqui você monta seu BottomSheet com os widgets que quiser, nele você utilizará o SnackBar.
        return Container(
          height: 200,
          color: Colors.blueGrey,
          child: Center(
            child: ElevatedButton(
              child: const Text('SNACKBAR'),
              onPressed: () {
                // EN: Any SnackBar in this context will appear above the BottomSheet, as desired.
                // PT-BR: Qualquer SnackBar neste contexto aparecerá acima do BottomSheet, como desejado.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('SNACKBAR! :)'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ),
        );
      },
    )
        .closed
        .whenComplete(
          () {
        if (mounted) {
          setState(
                () {
              _showPersistentBottomSheetCallBack = _showBottomSheet;
            },
          );
        }
      },
    );
  }
  _showBottomSheetDialog(BoxConstraints constraints, BuildContext context) {

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
                  mainAxisAlignment: MainAxisAlignment.end,

                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: constraints.maxHeight*0.02),
                          child: Text(
                            "Share Profile",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),)
                  ],
                ),

                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       width: constraints.maxWidth,
                //       color:Colors.yellow,
                //
                //         child: Text('Share Profile',textAlign: TextAlign.center,)),
                //     Spacer(),
                //     Expanded(
                //       child: Align(
                //           alignment: Alignment.topRight,
                //           child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),)),
                //     ),
                //   ],
                // ),
              ),
            ),
             Container(
                 margin: EdgeInsets.only(top: constraints.maxHeight*0.05),
                 child: Image.asset("assets/qr.png",height:constraints.maxHeight*0.08,width: constraints.maxWidth*0.15,fit: BoxFit.cover,)),

            GestureDetector(
              onTap: (){
                // const snackBar = SnackBar(
                //   content: Text('Copied to clipboard'),
                // );
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Container(
                margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.07),
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        print('he;;l');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Test'),
                          behavior: SnackBarBehavior.floating,
                        ));
                        // const snackBar = SnackBar(
                        //   behavior: SnackBarBehavior.floating,
                        //   content: Text('Copied to clipboard'),
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Card(child: Padding(
                        padding: EdgeInsets.only(left: constraints.maxWidth*0.03,right: constraints.maxWidth*0.03,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),

                        child: Icon(Icons.content_copy_outlined),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                      child: Text('tapitek/sudhanshu_juyal'),
                    )
                  ],
                ),

              ),
            ),
            Container(
              margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.01),
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Card(child: Padding(
                    padding: EdgeInsets.only(left: constraints.maxWidth*0.03,right: constraints.maxWidth*0.03,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),

                    child: Icon(Icons.share_outlined),
                  )),
                  Padding(
                    padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                    child: Text('Share Profile',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),),
                  )
                ],
              ),

            ),



          ],
        );
      },
    );
  }
}
