import 'package:flutter/material.dart';
import 'package:prizey_vendor/services/userServices.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'enterDetails.dart';
import 'loginPage.dart';

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController _pass = new TextEditingController();
  Color passClr = Colors.black12;
  Color confirmPassClr = Colors.black12;

  void changPassColor(String input) {
    setState(() {
      if (input.isNotEmpty) {
        passClr = Colors.red[100];
      } else {
        passClr = Colors.black12;
      }
    });
  }

  // void detectError() {
  //   setState(() {
  //     errorMsg = "Above field can't be empty";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final userAuth = Provider.of<UserAuth>(context);
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
                    'Enter OTP :',
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
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'OTP',
                            hintStyle: hintStyle,
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.vpn_key,
                              size: SizeConfig.safeBlockVertical * 3,
                            )),
                        onChanged: (String pass) {
                          pass = _pass.text;
                          changPassColor(pass);
                        },
                      ),
                    )),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 3,
                ),
                // new Container(
                //   padding: EdgeInsets.only(
                //       left: SizeConfig.safeBlockHorizontal * 30),
                //   child: new Text(
                //     (userAuth.verifyOtpStatus != null &&
                //             userAuth.verifyOtpStatus.isNotEmpty)
                //         ? userAuth.verifyOtpStatus
                //         : userAuth.verifyOtpMsg,
                //     style: TextStyle(color: Colors.red),
                //   ),
                // ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 3,
                ),
                new Container(
                  height: SizeConfig.blockSizeVertical * 5.5,
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 25,
                      right: SizeConfig.safeBlockHorizontal * 25),
                  child: new RaisedButton(
                    onPressed: () async {
                      String otp = _pass.text;
                      // bool otpVerified = await userAuth.verifyOtp(otp);
                      // bool userExist = await userAuth.getRegisteredUser();
                      // if (otpVerified) {
                      //   if (userExist) {
                      //     Navigator.of(context).pushAndRemoveUntil(
                      //         MaterialPageRoute(builder: (context) => MyApp()),
                      //         ModalRoute.withName(''));
                      //     print('User exist hence logged in');
                      //   } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NameSignUp()));
                      print('Enter details screen');
                      //   }
                      // }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.green,
                    elevation: 0,
                    child: new Container(
                      child: new Text(
                        'Verify',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.safeBlockHorizontal * 5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
