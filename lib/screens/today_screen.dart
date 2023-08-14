import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_attendance/model/user.dart';
import 'package:intl/intl.dart';
import 'package:slide_action/slide_action.dart';

import '../components/today_screen_components/today_screen_checkInandOut_box.dart';
import '../components/today_screen_components/today_screen_datetime_rich_text.dart';
import '../components/today_screen_components/today_screen_fixed_text.dart';
import '../components/today_screen_components/today_screen_slider.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  String checkIn = "--/--";
  String checkOut = "--/--";

  Color primary = const Color(0xff200b72);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRecord();
  }

  void _getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Employee")
          .where('id', isEqualTo: User.employeeId)
          .get();

      DocumentSnapshot snapRecord = await FirebaseFirestore.instance
          .collection("Employee")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat(' MMMM yyyy').format(DateTime.now()))
          .get();

      setState(() {
        checkIn = snapRecord['checkIn'];
        checkOut = snapRecord['checkOut'];
      });
    } catch (e) {
      setState(() {
        String checkIn = "--/--";
        String checkOut = "--/--";
      });
    }
    print(checkIn);
    print(checkOut);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              FixedText(screenWidth: screenWidth, label: 'Welcome', fontSize: screenWidth/20, fontWeight: FontWeight.normal,),
              FixedText(screenWidth: screenWidth, label: "Employee ${User.employeeId}", fontSize: screenWidth/18, fontWeight: FontWeight.bold,),
              const SizedBox(height: 32,),
              FixedText(screenWidth: screenWidth, label:  "Today's Status", fontSize: screenWidth / 18, fontWeight: FontWeight.bold),

              CheckInOutBox(
                  screenWidth: screenWidth, checkIn: checkIn, checkOut: checkOut),
              StreamBuilder<Object>(
                  stream: Stream.periodic(const Duration(seconds: 1),
                      (count) => Duration(seconds: count)),
                  builder: (context, snapshot) {
                    return DateTimeRichText(screenWidth: screenWidth);
                  }),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat('hh:mm:ss a').format(DateTime.now()),
                  style: TextStyle(
                      fontSize: screenWidth / 20, color: Colors.black54),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              checkIn == "--/--"
                  ? Container(
                      child: SlideAction(
                        trackBuilder: (context, state) {
                          return SliderButton(
                              checkIn: checkIn, screenWidth: screenWidth);
                        },
                        thumbBuilder: (context, state) {
                          return Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                        action: () async {
                          // to get username
                          QuerySnapshot snap = await FirebaseFirestore.instance
                              .collection("Employee")
                              .where('id', isEqualTo: User.employeeId)
                              .get();

                          DocumentSnapshot snapRecord = await FirebaseFirestore
                              .instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy')
                                  .format(DateTime.now()))
                              .get();
                          DocumentReference recordDocRef = await FirebaseFirestore
                              .instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy')
                                  .format(DateTime.now()));

                          try {
                            String checkIn = snapRecord['checkIn'];

                            setState(() {
                              checkOut =
                                  DateFormat('hh:mm').format(DateTime.now());
                            });
                            recordDocRef.update({
                              'checkIn': checkIn,
                              'checkOut':
                                  DateFormat('hh:mm').format(DateTime.now())
                            });
                          } catch (e) {
                            setState(() {
                              checkIn =
                                  DateFormat('hh:mm').format(DateTime.now());
                            });
                            recordDocRef.set({
                              'checkIn':
                                  DateFormat('hh:mm').format(DateTime.now()),
                              'checkOut': "--/--"
                            });
                          }
                        },
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 32),
                      child: Text("You have completed this day",
                          style: TextStyle(
                              fontSize: screenWidth / 18,
                              fontWeight: FontWeight.bold)),
                    )
            ],
          ),
        ),
      ),
    );
  }
}


