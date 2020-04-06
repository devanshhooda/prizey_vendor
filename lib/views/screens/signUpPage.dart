import 'package:flutter/material.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';
import 'loginPage.dart';
import 'numberSignUp.dart';

class Name extends StatefulWidget {
  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  TextEditingController _name = new TextEditingController();
  String errorMsg = "";

  Color nameClr = Colors.black12;

  void changeNameColor(String input) {
    setState(() {
      if (input.isNotEmpty) {
        nameClr = Colors.red[100];
      } else {
        nameClr = Colors.black12;
      }
    });
  }

  void detectError() {
    setState(() {
      errorMsg = "Above field can't be empty";
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: new Center(
            child: new ListView(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(
                      right: SizeConfig.safeBlockHorizontal * 70,
                      top: SizeConfig.safeBlockVertical * 2),
                  child: new CircleAvatar(
                    radius: SizeConfig.blockSizeVertical * 2.2,
                    backgroundColor: Colors.indigoAccent,
                    child: new IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: SizeConfig.safeBlockVertical * 2.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 10,
                ),
                new Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 33),
                  child: new Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 10,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical * 9,
                      left: SizeConfig.safeBlockHorizontal * 9),
                  child: new Text(
                    'Enter your name :',
                    style:
                        TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 5),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 3,
                ),
                new Container(
                  height: SizeConfig.blockSizeVertical * 6,
                  padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal * 7,
                    right: SizeConfig.safeBlockHorizontal * 7,
                  ),
                  child: new Container(
                    padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 3,
                      top: SizeConfig.safeBlockHorizontal * 0.5),
                    decoration: BoxDecoration(
                      color: nameClr,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: new TextField(
                      controller: _name,
                      style: inputTextStyle,
                      textCapitalization: TextCapitalization.words,
                      cursorWidth: 2.5,
                      cursorColor: Colors.indigo,
                      decoration: InputDecoration(
                          hintText: 'Chris Evans',
                          hintStyle: hintStyle,
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.person,
                            size: SizeConfig.safeBlockVertical * 3,
                          )),
                      onChanged: (String name) {
                        name = _name.text;
                        changeNameColor(name);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                new Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 30),
                  child: new Text(
                    errorMsg,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 3,
                ),
                new Container(
                  height: SizeConfig.blockSizeVertical * 5.5,
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 60,
                      right: SizeConfig.safeBlockHorizontal * 5),
                  child: new RaisedButton(
                    onPressed: () {
                      if (_name.text.isNotEmpty) {
                        print('No. Screen');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PhoneNumber()));
                      } else {
                        detectError();
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.green,
                    elevation: 0,
                    child: new Container(
                      child: new Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.safeBlockHorizontal * 5),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 4,
                ),
                new Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 45),
                  child: new Text(
                    'OR',
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 4,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 4,
                ),
                new Container(
                    height: SizeConfig.blockSizeVertical * 8,
                    padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 10,
                        right: SizeConfig.safeBlockHorizontal * 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: new Card(
                      // elevation: 10,
                      margin:
                          EdgeInsets.all(SizeConfig.safeBlockHorizontal * 0.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: new MaterialButton(
                        padding:
                            EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
                        onPressed: () => print('Google Sign In method'),
                        child: new Row(
                          children: <Widget>[
                            new CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: new Image.asset(
                                'assets/gLogo.png',
                                height: SizeConfig.blockSizeVertical * 5,
                                width: SizeConfig.blockSizeHorizontal * 13.5,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.safeBlockHorizontal * 2)),
                            new Text(
                              'Sign In with Google',
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
                            )
                          ],
                        ),
                      ),
                    )),
                new Container(
                  padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical * 6,
                      left: SizeConfig.safeBlockHorizontal * 15,
                      // right: SizeConfig.safeBlockHorizontal * 5,
                      bottom: SizeConfig.safeBlockVertical * 5),
                  child: new Row(
                    children: <Widget>[
                      new Text(
                        'Already have an account ?',
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 4),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.safeBlockHorizontal * 3)),
                      new GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                          print('Login Page');
                        },
                        child: new Text(
                          'Login.',
                          style: TextStyle(
                              letterSpacing: 1,
                              fontSize: SizeConfig.safeBlockHorizontal * 5,
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
