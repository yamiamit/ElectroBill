
import 'package:flutter/material.dart';
import 'package:frontend/components/NewWidget.dart';
import 'package:frontend/constants/constants_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
final _auth = FirebaseAuth.instance;
late String email;
late String password;
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset(
                    'assets/images/elec_bill.jpg',
                    height: 90.0,
                  )
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: ktextdecoration.copyWith(hintText: 'Enter Your Email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: ktextdecoration.copyWith(hintText: 'Enter Your Password')
            ),
            SizedBox(
              height: 24.0,
            ),
            NewWidget(
              color: Colors.lightBlueAccent,
              text: Text(
                'Login',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => HomeScreen(name: email)));
                  }
                } catch(e){
                  showDialog(context: context,
                      builder: (BuildContext context)
                      {
                        return AlertDialog(
                          title: Center(child: Text('ERROR'),),
                          content: Text('USER IS NOT REGISTERED, KINDLY REGISTER'),
                          actions: <Widget>[
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                            },
                                child: Text('OK'))
                          ],
                        );
                      }
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
