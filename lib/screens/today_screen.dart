import 'package:flutter/material.dart';
import 'package:slide_action/slide_action.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xff200b72);

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
                "Employee",
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
                          "09:30",
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
                          "11:30",
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
            Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      text: "11",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: screenWidth / 18,
                      ),
                      children: [
                        TextSpan(
                          text: " Jan 2020",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth / 18,
                          ),
                        )
                      ]),
                )),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "20:00:01",
                style: TextStyle(
                    fontSize: screenWidth / 20, color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
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
                        state.isPerformingAction
                            ? "Loading..."
                            : "Slide to Check Out",
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
                action: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

