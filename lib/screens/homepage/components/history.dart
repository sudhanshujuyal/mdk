
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/database/database_helper.dart';
import 'package:mdk/utils/configuration.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../../bloc/HomepageBloc/homepage_bloc.dart';
import '../../../bloc/HomepageBloc/homepage_event.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final GlobalKey<NavigatorState> key =
  GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopCallback,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: key,
          body: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        // The containers in the background
                        Container(
                            width: constraints.maxWidth,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Image.asset("assets/nfc.jpg",
                              height: constraints.maxHeight * 0.2,
                              width: constraints.maxWidth,
                              fit: BoxFit.cover,)),

                        Stack(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .16,
                                  right: 20.0,
                                  left: 20.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 10,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: const TabBar(
                                  indicatorSize: TabBarIndicatorSize.label,
                                  tabs: [
                                    Tab(child: FittedBox(child: Text('Write', style: TextStyle(color: Colors.black),)) ),
                                    Tab(child: FittedBox(child: Text('Read', style: TextStyle(color: Colors.black),)) ),
                                  ],
                                ),
                              ),
                            ),


                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(
                          children: [
                            WriteScreen(),
                            ReadScreen(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );

  }

  Future<bool> _onWillPopCallback()async
  {
    context.read<HomePageBloc>().add(HomePageInitialEvent());
    return false;
  }
}

class WriteScreen extends StatelessWidget {
  WriteScreen({Key? key}) : super(key: key);

  final DatabaseHelper helper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: helper.queryGetTypeList('Write'),
        builder: (context, snapshot){
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.hasData){
            if(snapshot.data!.isNotEmpty){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                return Container(
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                          child: FittedBox(child: Icon(imagemap[snapshot.data![index]['type']], size: 20))),
                      const SizedBox(width: 5,),
                      Expanded(
                        flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            FittedBox(
                              child: Text(snapshot.data![index]['message']),
                            ),
                            FittedBox(
                              child: Text(snapshot.data![index]['type'] +" (${snapshot.data![index]['size']} byte)"),
                            ),
                            FittedBox(
                              child: Text(snapshot.data![index]['date']),
                            ),
                          ],))
                    ],
                  ),
                );
              });
            }else{
              return Center(
                child: Text("No item Found", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.5), color: Colors.black, fontWeight: FontWeight.bold),),
              );
            }
          }else{
            return Container();
          }
        },
      ),
    );
  }
}

class ReadScreen extends StatelessWidget {
  ReadScreen({Key? key}) : super(key: key);
  final DatabaseHelper helper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: helper.queryGetTypeList('Read'),
        builder: (context, snapshot){
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.hasData){
            if(snapshot.data!.isNotEmpty){
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    return Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: FittedBox(child: Icon(imagemap[snapshot.data![index]['type']], size: 20))),
                          const SizedBox(width: 5,),
                          Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(snapshot.data![index]['message']),
                                  ),
                                  FittedBox(
                                    child: Text(snapshot.data![index]['type'] +" (${snapshot.data![index]['size']} byte)"),
                                  ),
                                  FittedBox(
                                    child: Text(snapshot.data![index]['date']),
                                  ),
                                ],))
                        ],
                      ),
                    );
                  });
            }else{
              return Center(
                child: Text("No item Found", style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.5), color: Colors.black, fontWeight: FontWeight.bold),),
              );
            }
          }else{
            return Container();
          }
        },
      ),
    );
  }
}

