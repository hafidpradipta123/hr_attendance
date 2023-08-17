import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hr_attendance/model/user.dart';
import 'package:hr_attendance/screens/home_screen.dart';
import 'package:hr_attendance/screens/login_Screen/login_screen.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:" this is the title",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const KeyboardVisibilityProvider(child: AuthCheck(),
      ),
      localizationsDelegates:const [
      MonthYearPickerLocalizations.delegate,]
    );

  }
}


class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;
  @override

  void initState() {

    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async{
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      if(sharedPreferences.getString('employeeId')!= ""){
        setState(() {
          User.employeeId = sharedPreferences.getString("employeeId")!;
          userAvailable = true;
        });
      }
    } catch(e){
      userAvailable = false;

    }
  }


  Widget build(BuildContext context) {
    return userAvailable ? const HomeScreen(): const LoginScreen();
  }
}
