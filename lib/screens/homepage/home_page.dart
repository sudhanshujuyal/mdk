import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';
import 'package:mdk/screens/homepage/components/device_compatablity.dart';
import 'package:mdk/screens/homepage/components/homescreen_page.dart';
import 'package:mdk/screens/homepage/components/question.dart';
import 'package:mdk/screens/homepage/components/verify_token.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/HomepageBloc/homepage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/screens/homepage/components/erasetag.dart';
import '../../bloc/HomepageBloc/homepage_state.dart';
import 'components/appinfo.dart';
import 'components/history.dart';
import 'components/login.dart';
import 'components/read_tag.dart';
import 'components/social_link.dart';
import 'components/splash_screen.dart';
import 'components/write_data.dart';
import 'components/write_detail.dart';
import 'components/write_tag.dart';

class HomePage extends StatelessWidget
{
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) =>  HomePage());
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints)
      {
        return Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
               return GestureDetector(
                 onTap: (){
                   Scaffold.of(context).openDrawer();
                 },
                 child: const ImageIcon(
                    AssetImage("assets/hamburger.png"),
                    color: Colors.black,
                    size: 24,
                  ),
               );

              },
            ),
            actions: [
              GestureDetector(
                onTap: (){
                  _showBottomSheetDialog(constraints,context);
                },
                child: Container(
                    margin: EdgeInsets.only(right: constraints.maxWidth*0.02),
                    child: const Icon(Icons.qr_code_scanner_outlined,color: Colors.white,)),
              )
            ],
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xFF3366FF),
                      Color(0xFF00CCFF),

                    ]),

              ),
            ),
            title: const Text(
              'Tapitek',
            ),
            // backgroundColor:  Colors.blue,
          ),
          drawer: Drawer(

            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                 Container(
                   height: constraints.maxHeight*0.15,
                   child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/user.png",),
                        SizedBox(width: 20,),
                        Text('sudhanshu_juyal',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),fontWeight: FontWeight.bold),)
                      ],
                    ),
                ),
                 ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                       Navigator.pop(context);
                      _showCompleteProfileDialog(constraints, context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: constraints.maxHeight*0.02,left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,bottom:  constraints.maxHeight*0.02),
                      color: Colors.white,
                      // margin: EdgeInsets.only(left: constraints.maxWidth*0.05),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.supervised_user_circle_outlined,
                          ),
                          SizedBox(width: 10,),
                          Text('Complete Profile',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      )
                    ),
                  ),
                Container(
                    padding: EdgeInsets.only(top: constraints.maxHeight*0.02,left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,bottom:  constraints.maxHeight*0.02),
                    color: Colors.white,
                    margin: EdgeInsets.only(top: constraints.maxHeight*0.03),
                    child: Column(
                      children: [

                        const SizedBox(height: 10,),
                        Row(
                          children: const [
                            Icon(Icons.supervised_user_circle_outlined,),
                            SizedBox(width: 10,),
                            Text('My Connection',style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                            context.read<HomePageBloc>().add(HomePageInitialEvent());
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.home,),
                              SizedBox(width: 10,),
                              Text('Homepage',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                                 context.read<HomePageBloc>().add(DeviceCompatibilityEvent());
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.smartphone_outlined,
                              ),
                              SizedBox(width: 10,),
                              Text('Device compatibility',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),


                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);

                            context.read<HomePageBloc>().add(QuestionEvent());
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.help_outline_outlined,
                              ),
                              SizedBox(width: 10,),
                              Text('Help',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),


                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                            __showSettingDialog(constraints,context);
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.settings_outlined,
                              ),
                              SizedBox(width: 10,),
                              Text('Settings',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),


                        GestureDetector(
                          onTap: ()async{
                            Navigator.pop(context);
                            final prefs = await SharedPreferences.getInstance();
                            var loginType = prefs.getString("LoginType");
                            if(loginType == "Facebook"){
                              prefs.clear();
                            }else if(loginType == "Google"){
                              prefs.clear();
                            }else{
                              prefs.clear();
                            }
                            context.read<HomePageBloc>().add(LoginEvent());
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.logout_outlined,
                              ),
                              SizedBox(width: 10,),
                              Text('Logout',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ],
                    )
                ),

              ],
            ),
          ),
          body: BlocBuilder<HomePageBloc,HomePageState>(
              builder: (context, state)
              {
                if(state is SplashState)
                {
                  return const Splash();
                }
                else if(state is VerifyTokenState)
                {
                  return const VerifyToken();
                }
                else if(state is LoginState)
                {
                  return const Login();
                }
                else if(state is HomePageInitialState)
                {
                  return const HomeScreenPage();
                }
                else if(state is WriteDataState)
                {
                  return const WriteData();
                }
                else if(state is WriteTagState)
                {
                  return const WriteTag();
                }
                else if(state is WriteDetailState)
                {
                  return WriteDetail(appTitle:state.appTitle);
                }
                else if(state is ReadTagState)
                {
                  return const ReadTag();
                }
                else if(state is HistoryState)
                {
                  return const History();
                }
                else if(state is EraseState)
                {
                  return const EraseTag();
                }
                else if(state is AppInfoState)
                {
                  return const AppInfo();
                }
                else if(state is SocialLinkState)
                {
                  return const SocialLink();
                }
                else if(state is QuestionState)
                  {
                    return Questions();
                  }
                else if(state is DeviceCompatibilityState)
                  {
                    return DeviceCompatibility();
                  }
                return const WriteTag();
              }),

        );
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

              ),
            ),
            Container(
                margin: EdgeInsets.only(top: constraints.maxHeight*0.05),
                child: Image.asset("assets/qr.png",height:constraints.maxHeight*0.08,width: constraints.maxWidth*0.15,fit: BoxFit.cover,color: Colors.black,)),

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
  _showCompleteProfileDialog(BoxConstraints constraints, BuildContext context) {

    return showModalBottomSheet<void>(
      backgroundColor: const Color(0xfff1f1f1),
      // context and builder are
      // required properties in this widget
      context: context,
      builder: (context1) {
        // we set up a container inside which
        // we create center column and display text

        return SingleChildScrollView(
          child: Column(
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
                              "Complete your profile",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),)
                    ],
                  ),

                ),



              ),
              profileContainer(constraints,context,'Verify Email address','Check your inbox for  juyalsudhanshu6@gmail.com'),
              profileContainer(constraints,context,'Add your first link','Tap here to add your social media channel \nor contact information to your tapni profile'),
              profileContainer(constraints,context,'Add a profile picture','Tap here to upload your profile picture'),
              profileContainer(constraints,context,'Activate your tapni','Tap here to activate your Tapni NFC tag'),

            ],
          ),
        );
      },
    );
  }


 Widget profileContainer(BoxConstraints constraints,BuildContext context,String title,String subTitle)
 {
   return GestureDetector(
     onTap: (){

     },
     child: Container(
       margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.05),
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(10),
       ),
       child: Padding(
         padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children:
               [
                 Text(title,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),color: Colors.black,fontWeight: FontWeight.bold),),
                 Container(
                   decoration: const BoxDecoration(
                       shape: BoxShape.circle,
                       color: Colors.grey
                   ),
                   child: Padding(
                     padding:  EdgeInsets.only(left: constraints.maxWidth*0.01,right: constraints.maxWidth*0.01,top: constraints.maxHeight*0.01,bottom: constraints.maxHeight*0.01),
                     child: const Icon(Icons.done),
                   ),
                 )
               ],
             ),
             Container(

                 child: Text(subTitle,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),color: Colors.black),textAlign: TextAlign.start,)),

           ],
         ),
       ),
     ),
   );
 }
  __showChangeUsernameDialog(BoxConstraints constraints, BuildContext context) {

    return showModalBottomSheet<void>(
      backgroundColor: const Color(0xfff1f1f1),
      // context and builder are
      // required properties in this widget
      context: context,
      builder: (context1) {
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
                            child:const Icon(Icons.perm_identity_outlined,color: Colors.black,size: 50,)

                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),)
                  ],
                ),

              ),
            ),
            Container(
              margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.05),
              child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 10.0,
                  shadowColor: Colors.black,
                  child: TextFormField(
                    initialValue: 'sudhanshu_juyal',
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
            SizedBox(height: 10,),
            Text('Enter your new username',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
            GestureDetector(
              onTap: (){
              },
              child: Container(
                margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.07),
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
                      child: Text('Update username',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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
  __showChangePasswordDialog(BoxConstraints constraints, BuildContext context) {

    return showModalBottomSheet<void>(
      backgroundColor: const Color(0xfff1f1f1),
      // context and builder are
      // required properties in this widget
      context: context,
      builder: (context1) {
        return SingleChildScrollView(
          child: Column(
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
                              child:const Icon(Icons.settings,color: Colors.black,size: 50,)

                          ),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),)
                    ],
                  ),

                ),
              ),
              Container(
                margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.05),
                child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10.0,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(


                          hintText: 'Current Password',
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
              Text('Enter your new current password',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
              Container(
                margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.02),
                child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10.0,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(


                          hintText: 'New password',
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
              Text('Enter your new password',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
              Container(
                margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.02),
                child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10.0,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(


                          hintText: 'Enter your new password again',
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
              Text('Enter your new password again',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
              GestureDetector(
                onTap: (){
                },
                child: Container(
                  margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.02),
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
                        child: Text('Password update',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      )
                    ],
                  ),

                ),
              ),
              const SizedBox(height: 40,),
            ],
          ),
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
                  mainAxisAlignment: MainAxisAlignment.end,

                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: constraints.maxHeight*0.02),
                          child:const Icon(Icons.settings,color: Colors.black,size: 50,)

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
                __showChangeUsernameDialog(constraints,context);
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                      child: Text('Username',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    )
                  ],
                ),

              ),
            ),
            GestureDetector(
              onTap: (){
                __showChangePasswordDialog(constraints,context);
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
                      child: Text('Change Password',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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
