import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_bloc.dart';
import 'package:mdk/bloc/profileBloc/profile_bloc.dart';
import 'package:mdk/bloc/profileBloc/profile_event.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../../utils/configuration.dart';
class SocialLink extends StatefulWidget {
  const SocialLink({Key? key}) : super(key: key);

  @override
  State<SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<SocialLink> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints)
      {
        return WillPopScope(
          onWillPop: _onWillPopCallback,
          child: Scaffold(
            backgroundColor: const Color(0xffF1F7F9),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: constraints.maxWidth,
                      margin: EdgeInsets.only(top: constraints.maxHeight*0.09,),
                      child: Text('Choose a link type',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.1),fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                  ),
                  Container(
                    width: constraints.maxWidth,
                    // color: Colors.black,
                    margin: EdgeInsets.only(left: constraints.maxWidth*0.04,right: constraints.maxWidth*0.04,top: constraints.maxHeight*0.05),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10.0,
                      shadowColor: Colors.black,
                      child: TextFormField(

                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            hintText: 'Search...',
                            suffixIcon: const Icon(Icons.search),
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
                  Container(
                    width: constraints.maxWidth,
                    margin: EdgeInsets.only(top: constraints.maxHeight*0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Featured',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.1),fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                        const SizedBox(width: 10,),
                        const Icon(Icons.local_fire_department,color: Colors.deepOrange,)
                      ],
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: constraints.maxWidth*0.11,right: constraints.maxHeight*0.05,top: constraints.maxHeight*0.05,bottom: constraints.maxHeight*0.01),
                            decoration: BoxDecoration(
                              color: const Color(0xff83807b).withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.05,bottom: constraints.maxHeight*0.05),
                              child: const Icon(Icons.contacts_outlined,color: Colors.white,),
                            ),
                          ),
                          Text('Contact Card',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),),)
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          _showBottomSheetDialog(constraints,'customLink');
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: constraints.maxWidth*0.11,right: constraints.maxHeight*0.05,top: constraints.maxHeight*0.05,bottom: constraints.maxHeight*0.01),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding:  EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.05,bottom: constraints.maxHeight*0.05),
                                child: const Icon(Icons.link,color: Colors.black,),
                              ),
                            ),
                            Text('Custom Link',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),),)
                          ],
                        ),
                      )
                    ],
                  ),

                  getText('Social Media', constraints),
                  gridView(socialMedia,constraints),
                  getText('Portfolio', constraints),
                  gridView(portfolio,constraints),
                  getText('Music', constraints),
                  gridView(music,constraints),
                  getText('Buisness', constraints),
                  gridView(buisness,constraints),
                  getText('More', constraints),
                  gridView(more,constraints),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget gridView(List<Map> list, BoxConstraints constraints)
  {
    return      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: list.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: (){
              _showBottomSheetDialog(constraints,'notCustomLink');
            },
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(list[index]["value"],fit: BoxFit.cover,)),

                ),
                Text(list[index]["name"])
              ],
            ),
          );
        });
  }
  Widget getText(String text,BoxConstraints constraints)
  {
    return  Container(
        margin: EdgeInsets.only(top: constraints.maxHeight*0.05),
        child: Text(text,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.1),fontWeight: FontWeight.w600),textAlign: TextAlign.center,));
  }

   _showBottomSheetDialog(BoxConstraints constraints,String s) {
    return showModalBottomSheet<void>(
      backgroundColor: const Color(0xfff1f1f1),
      // context and builder are
      // required properties in this widget
      context: context,
      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text

      return Column(
        children: [
         GestureDetector(
           onTap: (){
             Navigator.pop(context);
           },
           child: Align(
               alignment: Alignment.topRight,
               child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),)),
         ),
          s=="notCustomLink"? Image.asset("assets/insta.png",height:constraints.maxHeight*0.08,width: constraints.maxWidth*0.15,):Container(
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10)
               ),
              child: Padding(
                padding: EdgeInsets.only(left: constraints.maxWidth*0.08,right: constraints.maxWidth*0.08,top: constraints.maxHeight*0.03,bottom: constraints.maxHeight*0.03),
                child: const Icon(Icons.link_outlined,size: 40,),
              )),
          s=="notCustomLink"? Container(
            width: constraints.maxWidth,
            // color: Colors.black,
            margin: EdgeInsets.only(left: constraints.maxWidth*0.22,right: constraints.maxWidth*0.22,top: constraints.maxHeight*0.01),

            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 10.0,
                shadowColor: Colors.black,
                child: TextFormField(
                   initialValue: 'Instagram',
                  cursorColor: Colors.black,
                  decoration: InputDecoration(


                      hintText: 'Link Text',
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
          ): Container(
            width: constraints.maxWidth,
            // color: Colors.black,
            margin: EdgeInsets.only(left: constraints.maxWidth*0.22,right: constraints.maxWidth*0.22,top: constraints.maxHeight*0.01),

            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 10.0,
                shadowColor: Colors.black,
                child: TextFormField(
                  initialValue: 'Custom Link',
                  cursorColor: Colors.black,
                  decoration: InputDecoration(


                      hintText: 'Link Text',
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
          Text('Set text under link icon',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
          const SizedBox(height: 20,),
          s=="notCustomLink"? Container(
            width: constraints.maxWidth,
            // color: Colors.black,
            margin: EdgeInsets.only(left: constraints.maxWidth*0.22,right: constraints.maxWidth*0.22,top: constraints.maxHeight*0.01),
            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 10.0,
                shadowColor: Colors.black,
                child: TextFormField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(


                      hintText: 'Instagram Username',
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
          ):Container(
            width: constraints.maxWidth,
            // color: Colors.black,
            margin: EdgeInsets.only(left: constraints.maxWidth*0.22,right: constraints.maxWidth*0.22,top: constraints.maxHeight*0.01),
            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 10.0,
                shadowColor: Colors.black,
                child: TextFormField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(


                      hintText: 'https://',
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
          Text('Enter your instagram username',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.only(top: constraints.maxHeight*0.05),
            child: Padding(
              padding:  EdgeInsets.only(left: constraints.maxWidth*0.06,right: constraints.maxWidth*0.06,top: constraints.maxHeight*0.01,bottom: constraints.maxHeight*0.01),
              child: Text('Save',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.5),fontWeight: FontWeight.bold),),
            ),
          )

        ],
      );
      },
    );
  }

  Future<bool> _onWillPopCallback()async
  {
    context.read<ProfileBloc>().add(ProfileInitialEvent());
    return false;
  }
}
