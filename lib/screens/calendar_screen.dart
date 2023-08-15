import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_attendance/components/checkInandOut_box.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../model/user.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xff200b72);
  String _month = DateFormat('MMMM').format(DateTime.now());

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
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  "My Attendance",
                  style: TextStyle(fontSize: screenWidth / 18),
                ),
              ),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 32),
                    child: Text(
                     _month,
                      style: TextStyle(fontSize: screenWidth / 18),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(top: 32),
                    child: GestureDetector(
                      onTap: () async{
                        final month = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2029),
                          builder: (context, child){
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: primary,
                                    secondary: primary,
                                    onSecondary: Colors.white

                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: primary
                                    )
                                  ),
                                ),
                                child: child!
                              );
                          }
                        );

                        if (month != null){
                          setState(() {
                            _month = DateFormat('MMMM').format(month);
                          });

                        }

                      },
                      child: Text(
                        "Pick A Month",
                        style: TextStyle(fontSize: screenWidth / 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,)
                ],
              ),
              const SizedBox(height: 12,),
              Container(
                height: screenHeight - screenHeight / 3.1,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Employee")
                      .doc(User.id)
                      .collection("Record")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final snap = snapshot.data!.docs;
                      return ListView.builder(
                          itemCount: snap.length,
                          itemBuilder: (context, index) {
                            return
                              DateFormat('MMMM').format( snap[index]['date'].toDate()) == _month ?
                              Container(
                              margin:  EdgeInsets.only(top: index > 0 ? 12  : 0, left: 6, right: 6),
                              height: 150,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(2, 2))
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.all(Radius.circular(20),),
                                      ),
                                      child: Center(
                                        child: Text(
                                        DateFormat('EE dd').format( snap[index]['date'].toDate()),
                                          style: TextStyle(
                                              fontSize: screenWidth/20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Check In",
                                          style: TextStyle(
                                              fontSize: screenWidth / 20,
                                              color: Colors.black54),
                                        ),
                                        Text(
                                          snap[index]['checkIn'],
                                          style: TextStyle(
                                              fontSize: screenWidth / 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Check Out",
                                          style: TextStyle(
                                              fontSize: screenWidth / 20,
                                              color: Colors.black54),
                                        ),
                                        Text(
                                          snap[index]['checkOut'],
                                          style: TextStyle(
                                              fontSize: screenWidth / 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ): const  SizedBox();
                          });
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
