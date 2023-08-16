import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/user.dart';



class CalendarScreenStreamHistory extends StatelessWidget {
  const CalendarScreenStreamHistory({
    super.key,
    required this.screenHeight,
    required String month,
    required this.primary,
    required this.screenWidth,
  }) : _month = month;

  final double screenHeight;
  final String _month;
  final Color primary;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                                borderRadius: const BorderRadius.all(Radius.circular(20),),
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
    );
  }
}


