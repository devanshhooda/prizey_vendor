
import 'package:flutter/material.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(
          child: AppBar(
            // backgroundColor: Colors.deepPurpleAccent,
            title: new Text('Notifications'),
          ),
          preferredSize: Size.fromHeight(SizeConfig.blockSizeVertical * 7)),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: new ListView.builder(
            itemCount: 10,
            itemBuilder: (context, int index) {
              return notifs();
            }),
      ),
    );
  }
}

Widget notifs() {
  return new Column(
    children: <Widget>[
      new ListTile(
          leading: notifPhoto(),
          title: new Container(
            padding: EdgeInsets.only(
              top: SizeConfig.safeBlockVertical * 1.5,
            ),
            child: Text('Notification title'),
          ),
          subtitle: new Container(
            padding:
                EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 1.5),
            child: new Text(
                'Here the subtitle aur description may come or this may bhi removed...'),
          )),
      new Divider()
    ],
  );
}

Widget notifPhoto() {
  return new Container(
    child: new CircleAvatar(
      radius: SizeConfig.blockSizeVertical * 3,
      backgroundColor: Colors.grey[300],
      child: FlutterLogo(
        size: SizeConfig.safeBlockVertical * 4,
      ),
    ),
  );
}
