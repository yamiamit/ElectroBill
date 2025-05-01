import 'package:frontend/components/NewWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/constants/constants_1.dart';
import 'package:flutter_svg/svg.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}
final _auth = FirebaseAuth.instance;
late String email;
late String password;

void _showCongratsAnimation(BuildContext context,String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Congratulations!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  child:  Image.asset(
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
              color: Colors.blueAccent,
              onPressed: () async {
                try {
                  final Newuser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if(Newuser != null)
                  {
                    _showCongratsAnimation(context, 'You have successfully Registered,Please go to login page to proceed');
                  } else{
                    _showErrorDialog(context, 'Unable to Register');
                  }
                } catch(e){
                  print(e);
                }
              },
              text: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
