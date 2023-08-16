import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_attendance/model/user.dart';
import 'package:hr_attendance/screens/calendar_screen.dart';
import 'package:hr_attendance/screens/profile_screen.dart';
import 'package:hr_attendance/screens/today_screen.dart';
import 'package:hr_attendance/services/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  String id = '';

  Color primary = const Color(0xff200b72);
  int currentIndex = 2;

  List<IconData> navigationIcons = [
    Icons.calendar_today,
    Icons.check,
    Icons.person
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getId();
  }

  void _startLocationService() async{
    LocationService().initialize();

    LocationService().getLongitude().then((value){
      setState(() {
        User.long= value!;
      });
    });

    LocationService().getLatitude().then((value){
      setState(() {
        User.long= value!;
      });
    });
  }
  
  void getId() async{
    QuerySnapshot snap = await FirebaseFirestore
        .instance.collection("Employee")
        .where('id', isEqualTo: User.employeeId)
        .get();

    setState(() {
      User.id = snap.docs[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          new CalendarScreen(),
          new TodayScreen(),
          new ProfileScreen()

        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: EdgeInsets.only(left: 12, right: 12, bottom: 24),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 2),
              )
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < navigationIcons.length; i++) ...<Expanded>{
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = i;
                        // print(currentIndex);
                      });
                    },
                    child: Container(
                      height: screenHeight,
                      width: screenWidth,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              navigationIcons[i],
                              size: i == currentIndex ? 40 : 30,
                              color: i == currentIndex ? primary : Colors.black26,
                            ),
                            i == currentIndex
                                ? Container(
                                    margin: EdgeInsets.only(top: 6),
                                    height: 3,
                                    width: 22,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                        color: primary),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              }
            ],
          ),
        ),
      ),
    );
  }
}
