import 'package:mdk/screens/homepage/components/verify_token.dart';

import '../../bloc/HomepageBloc/homepage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/screens/homepage/components/erasetag.dart';

import '../../bloc/HomepageBloc/homepage_bloc.dart';
import '../../bloc/HomepageBloc/homepage_state.dart';
import 'components/appinfo.dart';
import 'components/history.dart';
import 'components/homepage_initial.dart';
import 'components/login.dart';
import 'components/read_tag.dart';
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
    return Scaffold(
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
              return const HomePageInitial();
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
            return const WriteTag();
          }),

    );

  }
}
