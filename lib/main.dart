import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_bloc.dart';
import 'package:mdk/screens/homepage/components/login.dart';
import 'package:mdk/screens/homepage/components/splash_screen.dart';
import 'package:mdk/screens/homepage/components/verify_token.dart';
import 'package:mdk/screens/homepage/home_page.dart';

import 'bloc/authenticationBloc/authentication_bloc.dart';
import 'bloc/authenticationBloc/authentication_state.dart';
import 'bloc/bottomNavigationCubit/navigation_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => HomePageBloc(),
                ),
                BlocProvider(
                  create: (_) => NavigationCubit(),
                ),
                BlocProvider(
                  create: (_) => AuthenticationBloc(),
                ),
              ],
              child:AuthenticationPage()
          ));


  }
}
class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc,AuthenticationState>(
          builder: (context, state)
          {
            print('state is '+state.toString());
            if(state is AuthenticationSplashState)
              {
                 return const Splash();
              }
            else if(state is AuthenticationLoginState)
              {
                return const Login();
              }
            else if(state is AuthenticationVerifyTokenState)
              {
                return const VerifyToken();
              }
            else if(state is AuthenticationHomePageState)
              {
                return HomePage();
              }
            return Container();
          }),
    );
  }
}

