import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPage_state createState() => LoginPage_state();
}

class LoginPage_state extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  bool isLoading = false;

  signInWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email_controller.text, password: password_controller.text);
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('user not found')),
        );
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('wrong password')),
        );
      } else if (e.code == 'invalid-email') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('invalid email format')),
        );
      }
    }
  }

  void dispose_un() {
    email_controller.dispose();
    super.dispose();
  }

  void dispose_pw() {
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          child: Form(
            key: _formkey,
            child: Container(
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
                      width: 250,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(
                              255, 0, 0, 0), // Set the input text color here
                        ),
                        cursorColor: Colors.white,
                        controller: email_controller,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 109, 109, 109)),
                          hintText: 'Enter your email',
                        ),

                        /*decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 109, 109, 109)),
                        hintText: 'Enter your pregnant month',
                      ),
                      */
                      ),
                    ),
                  ),
                  Positioned(
                    left: 61,
                    top: 495,
                    child: Container(
                      width: 250,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(
                              255, 24, 24, 24), // Set the input text color here
                        ),
                        cursorColor: Colors.white,
                        controller: password_controller,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 109, 109, 109)),
                          hintText: 'Enter your password',
                        ),

                        /*decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 109, 109, 109)),
                        hintText: 'Enter your pregnant month',
                      ),
                      */
                      ),
                    ),
                  ),
                  /*Positioned(
                  left: 106,
                  top: 607,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Enter'),
                    width: 148,
                    height: 34,
                    decoration: ShapeDecoration(
                      color: Color(0xFF757BAE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                  ),
                ),*/
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
                    left: 90,
                    top: 615,
                    child: SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            signInWithEmailAndPassword();
                          }
                        },
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                  fontFamily: 'Inconsolata',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ),
                      /*child: Text(
                      'LOGIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 16,
                        fontFamily: 'Inconsolata',
                        fontWeight: FontWeight.w400,
                      ),
                    ),*/
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
