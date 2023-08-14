import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_attendance/model/user.dart';
import 'package:intl/intl.dart';
import 'package:slide_action/slide_action.dart';

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
          .where('id', isEqualTo: User.username)
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
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 32),
              child: Text(
                "Welcome",
                style: TextStyle(
                    color: Colors.black54, fontSize: screenWidth / 20),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Employee ${User.username}",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: screenWidth / 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 32),
              child: Text(
                "Today's Status",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: screenWidth / 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 32),
              height: 150,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Check In",
                          style: TextStyle(
                              fontSize: screenWidth / 20,
                              color: Colors.black54),
                        ),
                        Text(
                          checkIn,
                          style: TextStyle(
                              fontSize: screenWidth / 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Check Out",
                          style: TextStyle(
                              fontSize: screenWidth / 20,
                              color: Colors.black54),
                        ),
                        Text(
                          checkOut,
                          style: TextStyle(
                              fontSize: screenWidth / 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<Object>(
                stream: Stream.periodic(const Duration(seconds: 1),
                    (count) => Duration(seconds: count)),
                builder: (context, snapshot) {
                  return Container(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            text: DateTime.now().day.toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: screenWidth / 18,
                            ),
                            children: [
                              TextSpan(
                                text: DateFormat(' MMMM yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth / 20,
                                ),
                              )
                            ]),
                      ));
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
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              checkIn == "--/--"
                                  ? "Slide to Check Out"
                                  : "Slide to Check In",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: screenWidth / 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
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
                            .where('id', isEqualTo: User.username)
                            .get();

                        DocumentSnapshot snapRecord = await FirebaseFirestore
                            .instance
                            .collection("Employee")
                            .doc(snap.docs[0].id)
                            .collection("Record")
                            .doc(
                                DateFormat(' MMMM yyyy').format(DateTime.now()))
                            .get();
                        try {
                          String checkIn = snapRecord['checkIn'];

                          setState(() {
                            checkOut =
                                DateFormat('hh:mm').format(DateTime.now());
                          });
                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy')
                                  .format(DateTime.now()))
                              .set({
                            'checkIn': checkIn,
                            'checkOut': DateFormat('dd MMMM yyyy')
                                .format(DateTime.now())
                          });
                        } catch (e) {
                          setState(() {
                            checkIn =
                                DateFormat('hh:mm').format(DateTime.now());
                          });
                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy')
                                  .format(DateTime.now()))
                              .update({
                            'checkIn':
                                DateFormat('hh:mm').format(DateTime.now())
                          });
                        }
                      },
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 32),
                    child: Text("You have already check out",
                        style: TextStyle(
                            fontSize: screenWidth / 18,
                            fontWeight: FontWeight.bold)),
                  )
          ],
        ),
      ),
    );
  }
}
