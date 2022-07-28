
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>
{
  AuthenticationBloc() : super(AuthenticationSplashState()){
    on<AuthenticationSplashEvent>(_onAuthenticationSplashEvent);
    on<AuthenticationVerifyTokenEvent>(_onAuthenticationVerificationEvent);
    on<AuthenticationLoginEvent>(_onAuthenticationLoginEvent);
    on<AuthenticationHomepageEvent>(_onAuthenticationHomePageEvent);
  }


  FutureOr<void> _onAuthenticationSplashEvent(AuthenticationSplashEvent event, Emitter<AuthenticationState> emit)
  {
    emit(AuthenticationSplashState());
  }

  FutureOr<void> _onAuthenticationVerificationEvent(AuthenticationVerifyTokenEvent event, Emitter<AuthenticationState> emit)
  {
    emit(AuthenticationVerifyTokenState());
  }

  FutureOr<void> _onAuthenticationLoginEvent(AuthenticationLoginEvent event, Emitter<AuthenticationState> emit)
  {
    emit(AuthenticationLoginState());
  }

  FutureOr<void> _onAuthenticationHomePageEvent(AuthenticationHomepageEvent event, Emitter<AuthenticationState> emit)
  {
    emit(AuthenticationHomePageState());
  }
}