import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_state.dart';

class HomePageBloc extends Bloc<HomePageEvent,HomePageState>
{
  HomePageBloc() : super(HomePageInitialState()){
    on<SplashEvent>(_onSplashEvent);
    on<VerifyTokenEvent>(_onVerifyTokenEvent);
    on<LoginEvent>(_onLoginEvent);
    on<WriteTagEvent>(_onWriteTagEvent);
    on<HomePageInitialEvent>(_onHomePageInitialEvent);
    on<WriteDataEvent>(_onWriteDataEvent);
    on<WriteDetailEvent>(_onWriteDetailEvent);
    on<ReadTagEvent>(_onReadTagEvent);
    on<HistoryEvent>(_onHistoryEvent);
    on<EraseEvent>(_onEraseEvent);
    on<AppInfoEvent>(_onappinfoEvent);
    on<SocialLinkEvent>(_onSocialLinkEvent);
    on<DeviceCompatibilityEvent>(_onDeviceCompatablityEvent);
    on<QuestionEvent>(_onQuestionEvent);

  }

  FutureOr<void> _onSplashEvent(SplashEvent event, Emitter<HomePageState> emit)
  {
    emit(SplashState());
  }
  FutureOr<void> _onVerifyTokenEvent(VerifyTokenEvent event, Emitter<HomePageState> emit)
  {
    emit(VerifyTokenState());
  }
  FutureOr<void> _onLoginEvent(LoginEvent event, Emitter<HomePageState> emit)
  {
    emit(LoginState());
  }
  FutureOr<void> _onWriteTagEvent(WriteTagEvent event, Emitter<HomePageState> emit)
  {
    emit(WriteTagState());
  }

  FutureOr<void> _onHomePageInitialEvent(HomePageInitialEvent event, Emitter<HomePageState> emit)
  {
    emit(HomePageInitialState());
  }

  FutureOr<void> _onWriteDataEvent(WriteDataEvent event, Emitter<HomePageState> emit)
  {
    emit(WriteDataState());
  }

  FutureOr<void> _onWriteDetailEvent(WriteDetailEvent event, Emitter<HomePageState> emit)
  {
    String? appTitle= event.appTitle;
    emit(WriteDetailState(appTitle: appTitle));
  }

  FutureOr<void> _onReadTagEvent(ReadTagEvent event, Emitter<HomePageState> emit)
  {
    emit(ReadTagState());
  }

  FutureOr<void> _onHistoryEvent(HistoryEvent event, Emitter<HomePageState> emit) {
    emit(HistoryState());
  }

  FutureOr<void> _onEraseEvent(EraseEvent event, Emitter<HomePageState> emit) {
    emit(EraseState());
  }

  FutureOr<void> _onappinfoEvent(AppInfoEvent event, Emitter<HomePageState> emit) {
    emit(AppInfoState());
  }

  FutureOr<void> _onSocialLinkEvent(SocialLinkEvent event, Emitter<HomePageState> emit)
  {
    emit(SocialLinkState());
  }

  FutureOr<void> _onDeviceCompatablityEvent(event, Emitter<HomePageState> emit)
  {
    emit(DeviceCompatibilityState());
  }

  FutureOr<void> _onQuestionEvent(QuestionEvent event, Emitter<HomePageState> emit)
  {
    emit(QuestionState());
  }
}


