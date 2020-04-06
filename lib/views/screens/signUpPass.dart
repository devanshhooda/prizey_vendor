import 'package:flutter/material.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';
import '../../main.dart';
import 'loginPage.dart';

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController _pass = new TextEditingController();
  TextEditingController _cnfrmPass = new TextEditingController();
  TextStyle _style = new TextStyle(
      fontSize: SizeConfig.safeBlockHorizontal * 4, color: Colors.blue);
  String errorMsg = "";

  Color passClr = Colors.black12;
  Color confirmPassClr = Colors.black12;

  void changPassColor(String input, int i) {
    if (i == 1) {
      setState(() {
        if (input.isNotEmpty) {
          passClr = Colors.red[100];
        } else {
          passClr = Colors.black12;
        }
      });
    } else if (i == 2) {
      setState(() {
        if (input.isNotEmpty) {
          confirmPassClr = Colors.red[100];
        } else {
          confirmPassClr = Colors.black12;
        }
      });
    }
  }

  void detectError(bool i) {
    setState(() {
      if (i) {
        errorMsg = "Above fields can't be empty";
      } else {
        errorMsg = "Passwords doesn't match";
      }
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
                      icon: Icon(Icons.arrow_back_ios,
                          color: Colors.white,
                          size: SizeConfig.safeBlockVertical * 2.5),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 15,
                ),
                new Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 10),
                  child: new Text(
                    'Now choose a password :',
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
                        color: passClr,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: new TextField(
                        controller: _pass,
                        obscureText: true,
                        style: inputTextStyle,
                        cursorWidth: 2.5,
                        cursorColor: Colors.indigo,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: hintStyle,
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              size: SizeConfig.safeBlockVertical * 3,
                            )),
                        onChanged: (String pass) {
                          pass = _pass.text;
                          changPassColor(pass, 1);
                        },
                      ),
                    )),
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
                        color: confirmPassClr,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: new TextField(
                        obscureText: true,
                        controller: _cnfrmPass,
                        style: inputTextStyle,
                        cursorWidth: 2.5,
                        cursorColor: Colors.indigo,
                        decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: hintStyle,
                            border: InputBorder.none,
                            icon: Icon(Icons.lock,
                                size: SizeConfig.safeBlockVertical * 3)),
                        onChanged: (String cnfrmPass) {
                          cnfrmPass = _cnfrmPass.text;
                          changPassColor(cnfrmPass, 2);
                        },
                      ),
                    )),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 3,
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
                      left: SizeConfig.safeBlockHorizontal * 15,
                      right: SizeConfig.safeBlockHorizontal * 15),
                  child: new RaisedButton(
                    onPressed: () {
                      if (_pass.text.isEmpty || _cnfrmPass.text.isEmpty) {
                        detectError(true);
                      } else if (_pass.text != _cnfrmPass.text) {
                        detectError(false);
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => MyApp()),
                            ModalRoute.withName(''));
                        print('Home Page screen');
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.green,
                    elevation: 0,
                    child: new Container(
                      child: new Text(
                        'Create Account',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.safeBlockHorizontal * 5),
                      ),
                    ),
                  ),
                ),
                new Container(
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                          'By signing up, you agree to the Metaducator\'s'),
                      new FlatButton(
                          onPressed: () => print('Terms & Conditions Page'),
                          child: new Text('Terms & Conditions', style: _style)),
                      new Text('&'),
                      new FlatButton(
                          onPressed: () => print('Privacy policies Page'),
                          child: new Text(
                            'Privacy policies',
                            style: _style,
                          )),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
