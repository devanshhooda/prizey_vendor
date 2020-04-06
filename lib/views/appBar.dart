
import 'package:flutter/material.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';
import 'screens/notifications.dart';

TextEditingController _srch = new TextEditingController();

Widget app_Bar(BuildContext context) {
  SizeConfig().init(context);
  return PreferredSize(
      preferredSize: Size.fromHeight(SizeConfig.blockSizeVertical * 13),
      child: Container(
          child: new AppBar(
        backgroundColor: Colors.deepPurpleAccent[300],
        title: new Container(
          padding: EdgeInsets.only(
              left: SizeConfig.safeBlockHorizontal * 2,
              right: SizeConfig.safeBlockHorizontal * 2,
              bottom: SizeConfig.safeBlockVertical * 1),
          child: Text(
            'Prizey',
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 6, letterSpacing: 3),
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
            child: new Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal * 5,
                    right: SizeConfig.safeBlockHorizontal * 5,
                    bottom: SizeConfig.safeBlockVertical * 0.5),
                child: new Container(
                  margin: EdgeInsets.only(
                      bottom: SizeConfig.safeBlockVertical * 0.5,
                      top: SizeConfig.safeBlockVertical * 0.5),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: new TextField(
                      cursorColor: Colors.black,
                      cursorWidth: 1.5,
                      controller: _srch,
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                          color: Colors.black87),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: new TextStyle(
                            color: Colors.black54,
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                            fontWeight: FontWeight.w500),
                        hintText: 'Search',
                        icon: Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal * 4),
                            child: Icon(
                              Icons.search,
                              color: Colors.black54,
                              size: SizeConfig.safeBlockVertical * 2.5,
                            )),
                      )),
                )),
            preferredSize: Size.fromHeight(SizeConfig.blockSizeVertical * 3)),
        actions: <Widget>[
          new Container(
            padding: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 2),
            child: IconButton(
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (context) => Notifications());
                Navigator.push(context, route);
              },
              icon: Icon(
                Icons.notifications_none,
                size: SizeConfig.safeBlockVertical * 3,
              ),
            ),
            // new Positioned(
            //   left: SizeConfig.safeBlockHorizontal * 7,
            //   top: SizeConfig.safeBlockVertical * 1.5,
            //   child: new CircleAvatar(
            //     radius: SizeConfig.blockSizeVertical * 0.9,
            //     backgroundColor: Colors.pink[200],
            //     child: Text(
            //       '10',
            //       style: TextStyle(
            //           fontSize: SizeConfig.safeBlockHorizontal * 2.2,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black),
            //     ),
            //   ),
            // )
          )
        ],
      )));
}
