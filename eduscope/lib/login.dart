import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
                left: 35,
                top: 146,
                child: Container(
                  width: 310,
                  height: 254,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 130,
                top: 158,
                child: Text(
                  'EDUSCOPE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'JejuHallasan',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 61,
                top: 427,
                child: Container(
                  width: 243,
                  height: 34,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 61,
                top: 495,
                child: Container(
                  width: 243,
                  height: 34,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 106,
                top: 607,
                child: Container(
                  width: 148,
                  height: 34,
                  decoration: ShapeDecoration(
                    color: Color(0xFF757BAE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 400,
                child: SizedBox(
                  width: 167,
                  height: 18,
                  child: Text(
                    'username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inria Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 471,
                child: SizedBox(
                  width: 167,
                  height: 18,
                  child: Text(
                    'password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inria Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 70,
                top: 565,
                child: SizedBox(
                  width: 164,
                  height: 15,
                  child: Text(
                    "don't have an account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inria Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 236,
                top: 565,
                child: SizedBox(
                  width: 76,
                  height: 15,
                  child: Text(
                    'create one',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF648CC8),
                      fontSize: 16,
                      fontFamily: 'Inria Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 148,
                top: 615,
                child: SizedBox(
                  width: 64,
                  height: 15,
                  child: Text(
                    'LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 16,
                      fontFamily: 'Inconsolata',
                      fontWeight: FontWeight.w400,
                    ),
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
