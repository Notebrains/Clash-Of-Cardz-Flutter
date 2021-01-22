import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';

import 'login.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    setScreenOrientationToLandscape();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SizedBox.expand(
              child: Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/bg_img3.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      splashColor: Colors.grey,
                      child: Container(
                        alignment: Alignment.center,
                        width: 270,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/png/bg_button.png'),
                              fit: BoxFit.fill),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Image.asset('assets/icons/png/ic_music_on.png'),
                                onPressed: null,
                              ),
                              Text(
                                "Music",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                              Switch(
                                value: _value,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    _value = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ),
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                      },
                    ),
                    MaterialButton(
                      splashColor: Colors.grey,
                      child: Container(
                        width: 270,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/png/bg_button.png'),
                              fit: BoxFit.fill),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Image.asset('assets/icons/png/ic_notification_on.png'),
                                onPressed: null,
                              ),
                              Text(
                                "Notification",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                              Switch(
                                value: _value,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    _value = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ),
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                      },
                    ),
                    MaterialButton(
                      padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                      splashColor: Colors.grey,
                      child: Container(
                        width: 270,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/png/bg_button.png'),
                              fit: BoxFit.fill),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                          child: Text(
                            "Logout",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                      // ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));
                      },
                    ),

                    MaterialButton(
                      padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                      splashColor: Colors.grey,
                      child: Container(
                        width: 270,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/png/bg_button.png'),
                              fit: BoxFit.fill),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                          child: Text(
                            "Close",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                      // ),
                      onPressed: () {
                        goBackToPreviousScreen(context);
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Player Id: MIS0034521T",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'montserrat',
                            color: Colors.black87),
                      ),
                    ),

                    Text(
                      "Version: 1.0.1",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'montserrat',
                          color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
