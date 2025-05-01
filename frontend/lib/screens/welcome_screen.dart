import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:frontend/components/NewWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/svg.dart';


class WelcomeScreen extends StatefulWidget {
  static const id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
// remember this way to add a custom animation in ur project

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeFirebase();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller
        .forward(); //controller.forward basically makes value change from 0 to 1
    //addstatusListener is used to listen to change in status
    //animation.completed is for 0 to 1
    //animation.dismissed is for 1 to 0
    controller.addListener(() {
      setState(() {});
    });
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }
  late bool _loading = false;

  Future<void> signInWithGoogle() async {
    setState(() {
      _loading = true;
    });

    try {
      final GoogleSignIn googleSignIn =
      GoogleSignIn(scopes: ["profile", "email"]);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        print('Google sign-in was canceled by the user.');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        print('Google authentication failed: Missing tokens.');
        return;
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      print('Signed in as: ${userCredential.user?.displayName}');
      final googleName = userCredential.user?.displayName ?? "Not Provided";

      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(name: googleName),
          ),
        );
      }
    } catch (e) {
      print('Error during Google sign-in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred during Google sign-in.')),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }


  void _showLoginOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Login')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  setState(() {
                    signInWithGoogle();
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/google.svg',
                      height: 24.0,
                    ),
                    SizedBox(width: 10),
                    Text('Sign in with Google'),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.email, color: Colors.grey.shade400),
                    SizedBox(width: 10),
                    Text('Login with Email'),// if user doesnt want to involve google
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset(
                      'assets/images/elec_bill.jpg',
                      height: 90.0,
                    )
                  ),
                ),
                Expanded(
                  child: AnimatedTextKit(
                    //Anminated text kit to use we should use this
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Electro_Bill',
                        textStyle: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                        speed: Duration(milliseconds: 300),
                      ),
                    ],
                    totalRepeatCount: 1,
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            NewWidget(
                color: Colors.lightBlue,
                text: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _showLoginOptions(context);
                  });
                }),
            SizedBox(height: 5),
            NewWidget(
                color: Colors.blueAccent,
                text: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RegistrationScreen();
                        },
                      ),
                    );
                  });
                }),
          ],
        ),
      ),
    );
  }
}




