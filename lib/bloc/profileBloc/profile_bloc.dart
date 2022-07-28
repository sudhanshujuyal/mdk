import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/profileBloc/profile_event.dart';
import 'package:mdk/bloc/profileBloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>
{
  ProfileBloc() : super(ProfileInitialState()){
   on<ProfileInitialEvent>(_onProfileInitialEvent);
   on<AddLinkClicked>(_onProfileAddLinkState);
  }


  FutureOr<void> _onProfileInitialEvent(ProfileInitialEvent event, Emitter<ProfileState> emit)
  {
    emit(ProfileInitialState());
  }



  FutureOr<void> _onProfileAddLinkState(AddLinkClicked event, Emitter<ProfileState> emit)
  {
    emit(ProfileAddLinkState());
  }
}