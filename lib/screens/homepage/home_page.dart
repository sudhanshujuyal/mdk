import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';
import 'package:mdk/screens/homepage/components/erasetag.dart';
import 'package:mdk/screens/homepage/components/history.dart';
import 'package:mdk/screens/homepage/components/homepage_initial.dart';
import 'package:mdk/screens/homepage/components/write_data.dart';
import 'package:mdk/screens/homepage/components/write_tag.dart';

import '../../bloc/HomepageBloc/homepage_bloc.dart';
import '../../bloc/HomepageBloc/homepage_state.dart';
import 'components/appinfo.dart';
import 'components/read_tag.dart';
import 'components/write_detail.dart';

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
            if(state is HomePageInitialState)
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
