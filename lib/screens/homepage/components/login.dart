
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/HomepageBloc/homepage_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool login = false;
  String logintext = "Login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: 230,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        validator: (s){
                          if(s!.isEmpty){
                            return "Enter Email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          // fillColor: Colors.black.withOpacity(0.2),
                            filled: true,
                            hintText: "Enter Email",
                            helperStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
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
                                  width: 1),
                            ),
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        controller: passwordcontroller,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (s){
                          if(s!.isEmpty){
                            return "Enter Password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          // fillColor: Colors.black.withOpacity(0.2),
                            filled: true,
                            hintText: "Enter Password",
                            helperStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
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
                                  width: 1),
                            ),
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if(loginFormKey.currentState!.validate()){
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool("Login", true);
                    prefs.setString("Email", emailcontroller.text);
                    context.read<HomePageBloc>().add(HomePageInitialEvent());
                  }
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
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
                    boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
                  ),
                  child: login? const CircularProgressIndicator() : Text(logintext, textAlign: TextAlign.center, style: const TextStyle(color:Colors.white,fontWeight: FontWeight.bold, fontSize: 20),),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Image.asset("assets/onboard.jpg", fit: BoxFit.contain ,
                      width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height / 3 ,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Text("Hey, \nLogin Now.", textAlign: TextAlign.start, style: TextStyle(fontFamily: "JosefinSans", fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black, fontStyle: FontStyle.italic),),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("Many peoples use Tapittek to share their data/profile securely using NFC Card.", textAlign: TextAlign.start, style: TextStyle(fontFamily: "JosefinSans",fontSize: 25, color: Colors.black),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

