import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../bloc/HomepageBloc/homepage_bloc.dart';
import '../../../bloc/authenticationBloc/authentication_bloc.dart';
import '../../../bloc/authenticationBloc/authentication_event.dart';
import '../../../utils/authentication_repository.dart';

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
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  bool googleLogin = false;
  bool facebookLogin = false;
  String loginText = "Login";
  String googleLoginText = "Log in with Google";
  String facebookLoginText = "Log in with Facebook";
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "394273677735-krc7js4basa66onbcughntna2qrf1e71.apps.googleusercontent.com",
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  void initState() {
    super.initState();
    AuthenticationRepository.googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        if(mounted)
        {
          _currentUser = account;

        }
      });
      if(_currentUser!=null)
      {
        _handleGetContact(_currentUser!);
      }

    });
    AuthenticationRepository.googleSignIn.signInSilently();
  } // final fb = FacebookLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: 330,
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
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if(loginFormKey.currentState!.validate()){
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool("Login", true);
                    prefs.setString("LoginType", "Email");
                    prefs.setString("Email", emailcontroller.text);
                    // BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationHomepageEvent());

                    context.read<AuthenticationBloc>().add(AuthenticationHomepageEvent());
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
                  child: login? const CircularProgressIndicator() : Text(loginText, textAlign: TextAlign.center, style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold, fontSize: ResponsiveFlutter.of(context).fontSize(1.5)),),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  print('hello');
                  _handleSignIn(context);

                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0xFFFFFFFF),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
                  ),
                  child: googleLogin? const CircularProgressIndicator() : Row(
                    children: [
                      Expanded(flex: 1,child: Image.asset("assets/google.png", height: 30, width: 30,)),
                      Expanded(flex: 4,child: Text(googleLoginText, textAlign: TextAlign.center, style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: ResponsiveFlutter.of(context).fontSize(1.5)),)),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()  {
                  facebookLogginIn();
                  // setState((){
                  //   facebookLogin = true;
                  // });
                  // facebookLoginDetail();
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xFF2b5398),
                          Color(0xFF2b5398),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
                  ),
                  child: facebookLogin? const CircularProgressIndicator() : Row(
                    children: [
                      Expanded(flex: 1,child: Image.asset("assets/facebook.png", height: 30, width: 30,)),
                      Expanded(flex: 4,child: Text(facebookLoginText, textAlign: TextAlign.center, style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold, fontSize: ResponsiveFlutter.of(context).fontSize(1.5)),)),
                    ],
                  ),
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

  Future<void> _handleGetContact(GoogleSignInAccount user) async
  {
    if(mounted)
    {
      setState(() {
        _contactText = 'Loading contact info...';
      });
    }

    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      if(mounted)
      {
        setState(() {

          _contactText = 'People API gave a ${response.statusCode} '
              'response. Check logs for details.';
        });
      }

      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    if(mounted)
    {
      setState(() {
        if (namedContact != null) {
          _contactText = 'I see you know $namedContact!';
        } else {
          _contactText = 'No contacts to display.';
        }
      });
    }
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  void _handleSignIn(BuildContext context)async
  {
    try {
      GoogleSignInAccount? user=  await AuthenticationRepository.googleSignIn.signIn();
      if(user==null)
      {
        var snackBar = SnackBar(
          content: Text('Sign In Failed',style: const TextStyle(color: Colors.red),),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else {
        // AppString.signInUserName=user.displayName!;
        // AppString.signInEmail=user.email;
        print('user name'+user.displayName.toString());
        print('user email'+user.email.toString());
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("Login", true);
        prefs.setString("LoginType", "Google");
        prefs.setString("Email", user.email.toString());
        context.read<AuthenticationBloc>().add(AuthenticationHomepageEvent());


        // context.read<AuthenticationBloc>().add(const AuthenticationStatusChanged(AuthenticationStatus.homepage));
      }
    }
    catch (error)
    {
      print('error is this'+error.toString());
    }
  }

  void facebookLogginIn()async
  {
    try
    {
      final result=await FacebookAuth.i.login(permissions: ['public_profile','email']);
      if(result.status==LoginStatus.success)
      {
        final userData=await FacebookAuth.i.getUserData();
        print('user data is'+userData.toString());
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("Login", true);
        prefs.setString("LoginType", "facebook");
        prefs.setString("Email", userData['email']);
        context.read<AuthenticationBloc>().add(AuthenticationHomepageEvent());

      }

    }
    catch(error)
    {
      print('errir is'+error.toString());
      // devlog.log(error.obs.string);
    }
  }

  // Future<void> facebookLoginDetail()async {
  //   final res = await fb.logIn(customPermissions: ['email']);
  //
  //   print('Access token: ${res.status}');
  //
  //   switch (res.status) {
  //     case FacebookLoginStatus.success:
  //     // Logged in
  //     setState((){
  //       facebookLogin = false;
  //       facebookLoginText = "Login Success";
  //     });
  //     final email = await fb.getUserEmail();
  //
  //     final prefs = await SharedPreferences.getInstance();
  //     prefs.setBool("Login", true);
  //     prefs.setString("LoginType", "Facebook");
  //     prefs.setString("Email", email!);
  //     context.read<HomePageBloc>().add(HomePageInitialEvent());
  //     // Send access token to server for validation and auth
  //       final FacebookAccessToken? accessToken = res.accessToken;
  //       print('Access token: ${accessToken!.token}');
  //
  //       // Get profile data
  //       final profile = await fb.getUserProfile();
  //       print('Hello, ${profile!.name}! You ID: ${profile.userId}');
  //
  //       // Get user profile image url
  //       final imageUrl = await fb.getProfileImageUrl(width: 100);
  //       print('Your profile image: $imageUrl');
  //
  //       // Get email (since we request email permission)
  //       // But user can decline permission
  //       if (email != null) {
  //         print('And your email is $email');
  //       }
  //       break;
  //     case FacebookLoginStatus.cancel:
  //     // User cancel log in
  //       print('Cancel by User: ${res.error}');
  //       break;
  //     case FacebookLoginStatus.error:
  //     // Log in failed
  //       print('Error while log in: ${res.error}');
  //       break;
  //   }
  //
  // }

}

