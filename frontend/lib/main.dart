import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Myapp());
}


class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _MyappState extends State<Myapp> {
=======
import 'package:frontend/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/welcome_screen.dart';

void main() {
  //make sure to pass here isloggedin bool
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _MyappState extends State<Myapp> {

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: WelcomeScreen(),
<<<<<<< Updated upstream
      // home: widget.isLoggedIn ? HomeScreen() : loginScreen(),
      builder: EasyLoading.init(),
    );
  }
}
=======
      // home: widget.isLoggedIn ? FaultFinderApp() : loginScreen(),
    );
  }
}

>>>>>>> Stashed changes
