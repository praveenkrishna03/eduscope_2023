import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'widget_tree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Eduscope());
}

// Generated by: https://www.figma.com/community/plugin/842128343887142055/
class Eduscope extends StatelessWidget {
  const Eduscope({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
        ),
        home: const WidgetTree(),
        /*home: Scaffold(
          body: ListView(children: [
            StartingAnimation(),
          ]),
        ),*/
        routes: {'login': (context) => LoginPage()});
  }
}

class StartingAnimation extends StatefulWidget {
  @override
  _StartingAnimationState createState() => _StartingAnimationState();
}

class _StartingAnimationState extends State<StartingAnimation> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamed(context, 'widget_tree');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 386,
          height: 838,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 386,
                  height: 838,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8500000238418579),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 205,
                child: Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 360,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 93,
                top: 498,
                child: Text(
                  'EDUSCOPE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'JejuHallasan',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
