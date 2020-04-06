import 'package:flutter/material.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';
import 'package:prizey_vendor/views/screens/selectCategoryPage.dart';
import 'loginPage.dart';

class PhoneNumber extends StatefulWidget {
  // PhoneNumber(String name) {}
  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  TextEditingController _number = new TextEditingController();
  String errorMsg = "";

  Color nmbrClr = Colors.black12;

  void changeNameColor(String input) {
    setState(() {
      if (input.isNotEmpty) {
        nmbrClr = Colors.red[100];
      } else {
        nmbrClr = Colors.black12;
      }
    });
  }

  void detectError() {
    setState(() {
      errorMsg = "Above column can't be empty";
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
                  height: SizeConfig.safeBlockVertical * 25,
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
                        onChanged: (String nmbr) {
                          nmbr = _number.text;
                          changeNameColor(nmbr);
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
                  height: SizeConfig.safeBlockVertical * 5,
                ),
                new Container(
                  height: SizeConfig.blockSizeVertical * 5.5,
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 60,
                      right: SizeConfig.safeBlockHorizontal * 5),
                  child: new RaisedButton(
                    onPressed: () {
                      if (_number.text.isNotEmpty) {
                        print('Category & Address');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SelectCategory()));
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
              ],
            ),
          )),
    );
  }
}
