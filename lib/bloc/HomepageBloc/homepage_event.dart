import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable
{

}
class SplashEvent extends HomePageEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class VerifyTokenEvent extends HomePageEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class LoginEvent extends HomePageEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

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
class ReadTagEvent extends HomePageEvent
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

class HistoryEvent extends HomePageEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EraseEvent extends HomePageEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AppInfoEvent extends HomePageEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SocialLinkEvent extends HomePageEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class DeviceCompatibilityEvent extends HomePageEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class QuestionEvent extends HomePageEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
