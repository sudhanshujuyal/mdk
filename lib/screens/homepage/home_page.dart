import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/screens/homepage/components/homepage_initial.dart';
import 'package:mdk/screens/homepage/components/write_data.dart';
import 'package:mdk/screens/homepage/components/write_tag.dart';

import '../../bloc/HomepageBloc/homepage_bloc.dart';
import '../../bloc/HomepageBloc/homepage_state.dart';
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
                return HomePageInitial();
              }
            else if(state is WriteDataState)
              {
                return WriteData();
              }
            else if(state is WriteTagState)
              {
                return WriteTag();
              }
            else if(state is WriteDetailState)
              {

                return WriteDetail(appTitle:state.appTitle);
              }


            return WriteTag();
          }),

    );

  }
}
