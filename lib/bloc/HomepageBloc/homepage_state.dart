import 'package:equatable/equatable.dart';

abstract class HomePageState extends Equatable{


}
class HomePageInitialState extends HomePageState
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class WriteTagState extends HomePageState
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class WriteDataState extends HomePageState
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class WriteDetailState extends HomePageState
{
  String? appTitle;
  WriteDetailState({this.appTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [appTitle];
}
class ReadTagState extends HomePageState
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HistoryState extends HomePageState
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EraseState extends HomePageState
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AppInfoState extends HomePageState
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

