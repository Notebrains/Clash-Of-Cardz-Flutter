import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginStateFull(

      ),
    );
  }
}

class LoginStateFull extends StatefulWidget {
  const LoginStateFull({ Key key }) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}


class _LogInState extends State<LoginStateFull> {
  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFFFFE306));
  }
}
