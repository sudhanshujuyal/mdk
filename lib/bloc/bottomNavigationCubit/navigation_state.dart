import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/navbar_item.dart';

class NavigationState extends Equatable
{
final NavbarItem navBarItem;
final int index;
const NavigationState(this.navBarItem,this.index);

  @override
  // TODO: implement props
  List<Object?> get props => [navBarItem,index];
}