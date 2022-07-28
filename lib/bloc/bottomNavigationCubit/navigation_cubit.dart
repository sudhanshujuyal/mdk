import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/bloc/bottomNavigationCubit/navigation_state.dart';
import 'package:mdk/data/navbar_item.dart';

class NavigationCubit extends Cubit<NavigationState>
{
  NavigationCubit() : super(const NavigationState(NavbarItem.home, 0));
  void getNavbarItem(NavbarItem navbarItem)
  {
    switch(navbarItem)
    {
      case NavbarItem.home:
        emit(const NavigationState(NavbarItem.home, 0));
        break;
      case NavbarItem.activateTag:
        emit(const NavigationState(NavbarItem.activateTag, 1));
        break;
      case NavbarItem.profile:
        emit(const NavigationState(NavbarItem.profile, 2));
        break;
    }
  }

}