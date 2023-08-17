
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'calendar_screen_month_display.dart';
import 'calendar_screen_stream_history.dart';


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
        padding: const EdgeInsets.all(20),
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
                  MonthDisplay(month: _month, screenWidth: screenWidth),
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
              CalendarScreenStreamHistory(screenHeight: screenHeight, month: _month, primary: primary, screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }
}
