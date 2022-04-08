import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable
{

}
class HomePageInitialEvent extends HomePageEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class WriteTagEvent extends HomePageEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class WriteDataEvent extends HomePageEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class WriteDetailEvent extends HomePageEvent
{
  String? appTitle;
  WriteDetailEvent({this.appTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [appTitle];
}