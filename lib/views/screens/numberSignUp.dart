import 'package:flutter/material.dart';
import 'package:prizey_vendor/services/userServices.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';
import 'package:prizey_vendor/views/screens/loginPage.dart';
import 'package:provider/provider.dart';
import 'signUpOtp.dart';

class PhoneNumber extends StatefulWidget {
  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  static TextEditingController _number = new TextEditingController();
  static String phoneNumber = _number.text;
  TextStyle _style = new TextStyle(
      fontSize: SizeConfig.safeBlockHorizontal * 4, color: Colors.blue);
  Color nmbrClr = Colors.black12;

  // void changePhoneNumberColor(String input) {
  //   setState(() {
  //     if (input.isNotEmpty) {
  //       nmbrClr = Colors.red[100];
  //     } else {
  //       nmbrClr = Colors.black12;
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
                  height: SizeConfig.safeBlockVertical * 5,
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
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 7,
                ),
                new Container(
                  padding:
                      EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 7),
                  child: new Text(
                    'Please enter your phone number :',
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
                        color: nmbrClr,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: new TextField(
                        style: inputTextStyle,
                        controller: _number,
                        keyboardType: TextInputType.number,
                        cursorWidth: 2.5,
                        cursorColor: Colors.indigo,
                        decoration: InputDecoration(
                            hintText: 'e.x.- 987651234',
                            hintStyle: hintStyle,
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.phone,
                              size: SizeConfig.safeBlockVertical * 3,
                            )),
                        // onChanged: (String nmbr) {
                        //   nmbr = _number.text;
                        // changePhoneNumberColor(nmbr);
                        // },
                      ),
                    )),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                new Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 28),
                  child: new Text(
                    userAuth.sendOtpMsg,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 4,
                ),
                new Container(
                  height: SizeConfig.blockSizeVertical * 5.5,
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 30,
                      right: SizeConfig.safeBlockHorizontal * 30),
                  child: new RaisedButton(
                    onPressed: () async {
                      String phoneNumber = _number.text;
                      bool otpSent = await userAuth.sendOtp(phoneNumber);
                      if (otpSent) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Password()));
                        print('OTP Screen');
                      }
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
                            fontSize: SizeConfig.safeBlockHorizontal * 5),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
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
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                new Container(
                  padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal * 17,
                  ),
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
                ),
                new Container(
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 10),
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
