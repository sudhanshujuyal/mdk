import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_state.dart';

 class HomePageBloc extends Bloc<HomePageEvent,HomePageState>
{
  HomePageBloc() : super(HomePageInitialState()){
   on<WriteTagEvent>(_onWriteTagEvent);
   on<HomePageInitialEvent>(_onHomePageInitialEvent);
   on<WriteDataEvent>(_onWriteDataEvent);
   on<WriteDetailEvent>(_onWriteDetailEvent);
   on<ReadTagEvent>(_onReadTagEvent);

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
}