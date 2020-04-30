import 'package:flutter/material.dart';
import 'package:prizey_vendor/services/userServices.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';
import 'package:provider/provider.dart';
import 'loginPage.dart';
import 'numberSignUp.dart';

class OptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new Scaffold(
      body: _options(context),
    );
  }

  Widget _options(BuildContext context) {
    return new Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: Colors.white,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                child: new Text(
                  'Prizey',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.indigo),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 4,
              ),
              new Text(
                'Find the customer in your \n neighbourhood',
                style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              new Container(
                height: SizeConfig.blockSizeVertical * 60,
                width: SizeConfig.blockSizeHorizontal * 100,
                color: Colors.white70,
                padding: EdgeInsets.only(
                  left: SizeConfig.safeBlockHorizontal * 1,
                  right: SizeConfig.safeBlockHorizontal * 1,
                ),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 3,
                      ),
                      child: new Text(
                        'New User ?',
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: SizeConfig.safeBlockHorizontal * 6,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 2),
                    ),
                    new Container(
                      height: SizeConfig.blockSizeVertical * 8,
                      width: SizeConfig.blockSizeHorizontal * 45,
                      child: new Container(
                        height: SizeConfig.blockSizeVertical * 8.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            color: Colors.indigo[300]),
                        child: new MaterialButton(
                          onPressed: () {
                            print('Sign Up page');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (context) => UserAuth(),
                                      child: PhoneNumber(),
                                    )));
                          },
                          child: new Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.safeBlockHorizontal * 6),
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 5),
                      child: new Container(
                        child: new Text(
                          'OR',
                          style: TextStyle(
                              letterSpacing: 2,
                              color: Colors.indigoAccent[200],
                              fontSize: SizeConfig.safeBlockHorizontal * 5.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 5,
                      ),
                      child: new Text(
                        'Existing User ?',
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: SizeConfig.safeBlockHorizontal * 6,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 2),
                    ),
                    new Container(
                      child: new Container(
                        height: SizeConfig.blockSizeVertical * 8,
                        width: SizeConfig.blockSizeHorizontal * 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            color: Colors.indigo[300]),
                        child: new MaterialButton(
                          onPressed: () {
                            print('Login Page');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (context) => UserAuth(),
                                      child: LoginPage(),
                                    )));
                          },
                          child: new Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.safeBlockHorizontal * 6),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
