import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/screens/homepage/components/homepage_initial.dart';
import 'package:mdk/screens/homepage/components/profile.dart';
import 'package:mdk/screens/profile/profile_page.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../../bloc/bottomNavigationCubit/navigation_cubit.dart';
import '../../../bloc/bottomNavigationCubit/navigation_state.dart';
import '../../../bloc/profileBloc/profile_bloc.dart';
import '../../../data/navbar_item.dart';
import '../home_page.dart';
import 'activate_tag.dart';
class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocProvider(create: (context)=>NavigationCubit(),
          child: const Scaffold(
            body: BottomScreenPage(),
          )

      ) ,
    );
  }
}

class BottomScreenPage extends StatefulWidget {
  const BottomScreenPage({Key? key}) : super(key: key);

  @override
  State<BottomScreenPage> createState() => _BottomScreenPageState();
}

class _BottomScreenPageState extends State<BottomScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      bottomNavigationBar: BlocBuilder<NavigationCubit,NavigationState>(
        builder: (context,state)
        {
          return BottomNavigationBar(
            selectedLabelStyle: TextStyle(fontSize:ResponsiveFlutter.of(context).fontSize(1.3),fontWeight: FontWeight.bold),
            backgroundColor: Colors.black,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.shifting,
            showUnselectedLabels: false,
            currentIndex: state.index,

            items:   const [

              BottomNavigationBarItem(
                backgroundColor:Colors.white,
                activeIcon:  Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                icon:  Icon(
                  Icons.home,
                  color: Colors.black,
                ),

                label: 'home',
              ),
              BottomNavigationBarItem(
                backgroundColor:Colors.white,
                activeIcon:  Icon(
                  Icons.pending_outlined,
                  color: Colors.blue,
                ),
                icon:  Icon(
                  Icons.pending_outlined,
                  color: Colors.black,
                ),


                label: 'Activate Tag',
              ),
              BottomNavigationBarItem(
                backgroundColor:Colors.white,
                activeIcon:  Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                icon:  Icon(
                  Icons.person,
                  color: Colors.black,
                ),

                label: 'Profile',
              ),

            ],
            onTap: (index) {


              if (index == 0)
              {
                BlocProvider.of<NavigationCubit>(context).getNavbarItem(NavbarItem.home);
              }
              else if (index == 1)
              {
                BlocProvider.of<NavigationCubit>(context).getNavbarItem(NavbarItem.activateTag);
              }
              else if (index == 2)
              {
                BlocProvider.of<NavigationCubit>(context).getNavbarItem(NavbarItem.profile);
              }

            },
          );
        },

      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            if (state.navBarItem == NavbarItem.home) {
              return  const HomePageInitial();
            }
            if (state.navBarItem == NavbarItem.activateTag) {
              return  const ActivateTag();
            }

            else if (state.navBarItem == NavbarItem.profile)
            {
             return  BlocProvider(
                  create: (_) => ProfileBloc(
                  ),
              child:const ProfilePage());
            }

            return Container();
          }),
    );
  }
}
