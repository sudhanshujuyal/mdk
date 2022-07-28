import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/profileBloc/profile_bloc.dart';
import 'package:mdk/bloc/profileBloc/profile_event.dart';
import 'package:mdk/screens/homepage/components/social_link.dart';

import '../../bloc/profileBloc/profile_state.dart';
import '../homepage/components/profile.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc,ProfileState>(
        builder: (context,state)
    {
      if(state is ProfileInitialState)
      {
        return const Profile();
      }
      else if(state is ProfileAddLinkState)
      {
        return SocialLink();
      }
      return Container();

    }));
  }
}
