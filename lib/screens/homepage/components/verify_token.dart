
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/HomepageBloc/homepage_event.dart';

class VerifyToken extends StatefulWidget {
  const VerifyToken({Key? key}) : super(key: key);

  @override
  State<VerifyToken> createState() => _VerifyTokenState();
}

class _VerifyTokenState extends State<VerifyToken> {
  final TextEditingController tokencontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool verify = false;
  String verifytext = "Verify";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: 160,
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
                  key: formkey,
                  child: TextFormField(
                    controller: tokencontroller,
                    keyboardType: TextInputType.text,
                    validator: (s){
                      if(s!.isEmpty){
                        return "Enter Token First";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // fillColor: Colors.black.withOpacity(0.2),
                        filled: true,
                        hintText: "Verify Token",
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
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if(formkey.currentState!.validate()){
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool("Verify", true);
                    prefs.setString("Token", tokencontroller.text);
                    context.read<HomePageBloc>().add(LoginEvent());
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
                  child: verify? const CircularProgressIndicator() : Text(verifytext, textAlign: TextAlign.center, style: const TextStyle(color:Colors.white,fontWeight: FontWeight.bold, fontSize: 20),),
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
                child: Stack(
                  children: [
                    Image.asset("assets/onboard.jpg", fit: BoxFit.contain ,
                      width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height - 100 ,),
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Text("First, Verify you have our card", textAlign: TextAlign.center, style: TextStyle(fontFamily: "JosefinSans",fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("Use the Token provided by mail", textAlign: TextAlign.center, style: TextStyle(fontFamily: "JosefinSans",fontSize: 25, color: Colors.black),),
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
