import 'package:flutter/material.dart';
import 'package:prizey_vendor/services/userServices.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'numberSignUp.dart';

TextStyle inputTextStyle = TextStyle(
    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
    fontWeight: FontWeight.w600,
    color: Colors.black);

TextStyle hintStyle = TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 4.5);

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phNum = new TextEditingController();
  TextEditingController _otp = new TextEditingController();

  Color phnClr = Colors.black12;
  Color passClr = Colors.black12;
  bool isOtpSent = false;
  // void phoneChangeColor(String input) {
  //   setState(() {
  //     if (input.isNotEmpty) {
  //       phnClr = Colors.red[100];
  //     } else {
  //       phnClr = Colors.black12;
  //     }
  //   });
  // }

  // void passChangeColor(String input) {
  //   setState(() {
  //     if (input.isNotEmpty) {
  //       passClr = Colors.red[100];
  //     } else {
  //       passClr = Colors.black12;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<UserAuth>(context);
    return new Scaffold(
      body: new Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
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
              height: SizeConfig.safeBlockVertical * 7,
            ),
            new Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 37),
              child: new Text(
                'Login',
                style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 10,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 7,
            ),
            new Container(
              padding: EdgeInsets.only(
                left: SizeConfig.safeBlockHorizontal * 7,
                right: SizeConfig.safeBlockHorizontal * 7,
              ),
              child: new Container(
                  height: SizeConfig.blockSizeVertical * 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40), color: phnClr),
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 3,
                      top: SizeConfig.safeBlockHorizontal * 0.5),
                  child: new TextField(
                    controller: _phNum,
                    style: inputTextStyle,
                    keyboardType: TextInputType.number,
                    cursorWidth: 2,
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: hintStyle,
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.phone,
                        size: SizeConfig.safeBlockVertical * 3.5,
                      ),
                    ),
                    // onChanged: (String phn) {
                    //   phn = _phNum.text;
                    //   phoneChangeColor(phn);
                    // },
                  )),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            new Container(
              height: SizeConfig.blockSizeVertical * 6,
              padding: EdgeInsets.only(
                  left: SizeConfig.safeBlockHorizontal * 25,
                  right: SizeConfig.safeBlockHorizontal * 25),
              child: new RaisedButton(
                onPressed: () async {
                  String phoneNumber = _phNum.text;
                  isOtpSent = await userAuth.sendOtp(phoneNumber);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.green,
                elevation: 0,
                child: new Container(
                  child: new Text(
                    'Send OTP',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.safeBlockHorizontal * 4.5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 5,
            ),
            new Container(
              height: SizeConfig.blockSizeVertical * 6,
              padding: EdgeInsets.only(
                left: SizeConfig.safeBlockHorizontal * 7,
                right: SizeConfig.safeBlockHorizontal * 7,
              ),
              child: new Container(
                height: SizeConfig.blockSizeVertical * 7,
                padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal * 3,
                    top: SizeConfig.safeBlockHorizontal * 0.5),
                decoration: BoxDecoration(
                  color: passClr,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: new TextField(
                  obscureText: true,
                  controller: _otp,
                  style: inputTextStyle,
                  cursorWidth: 2.5,
                  cursorColor: Colors.indigo,
                  enabled: isOtpSent,
                  decoration: InputDecoration(
                    hintText: 'OTP',
                    hintStyle: hintStyle,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      size: SizeConfig.safeBlockVertical * 3,
                    ),
                  ),
                  // onChanged: (String otp) {
                  //   otp = _otp.text;
                  //   passChangeColor(otp);
                  // },
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            new Container(
              height: SizeConfig.blockSizeVertical * 6,
              padding: EdgeInsets.only(
                  left: SizeConfig.safeBlockHorizontal * 25,
                  right: SizeConfig.safeBlockHorizontal * 25),
              child: new RaisedButton(
                onPressed: () async {
                  String otp = _otp.text;
                  bool otpVerified = await userAuth.verifyOtp(otp);
                  bool userExist = await userAuth.getRegisteredUser();
                  if (otpVerified) {
                    if (userExist) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MyApp()),
                          ModalRoute.withName(''));
                      print('User exist hence logged in');
                    } else {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                    create: (context) => UserAuth(),
                                    child: PhoneNumber(),
                                  )),
                          ModalRoute.withName('/'));
                      print('User does\'t exist hence sign up screen');
                    }
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.green,
                elevation: 0,
                child: new Container(
                  child: new Text(
                    'Verify & Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.safeBlockHorizontal * 4.5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 4,
            ),
            new Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 30),
              child: new Text(
                userAuth.verifyOtpMsg.isEmpty
                    ? userAuth.sendOtpMsg
                    : userAuth.verifyOtpMsg,
                style: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3,
            ),
            new Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 45),
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
                  margin: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 0.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: new MaterialButton(
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
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
          ],
        ),
      ),
    );
  }
}
