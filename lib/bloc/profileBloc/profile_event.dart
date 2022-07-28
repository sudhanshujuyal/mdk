import 'package:equatable/equatable.dart';
import 'package:mdk/screens/homepage/components/profile.dart';

abstract class ProfileEvent extends Equatable
{

}
class ProfileInitialEvent extends ProfileEvent
{
  @override
  List<Object?> get props => [];
}
class AddLinkClicked extends ProfileEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}