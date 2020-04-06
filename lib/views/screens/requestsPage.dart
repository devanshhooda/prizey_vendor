import 'package:flutter/material.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';
import 'bookings.dart';

TextStyle _subtitle =
    new TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.5);

class Requests extends StatelessWidget {
  List<String> titles = [
    'Macbook Air (13 inch)',
    'Onida Washing machine',
    'Fastrack Watch'
  ];

  List<String> categories = ['Laptop', 'Electronics', 'Watch'];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 1),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, int i) {
          return _requests(context, titles[i], categories[i], i);
        },
      ),
    ));
  }
}

Widget _requests(BuildContext context, String title, String categories, int i) {
  return new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      new ListTile(
        leading: profilePhoto(context, i),
        title: new Container(
          child: Text(
            '$title',
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 4,
                color: Colors.black,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
        ),
        subtitle: new Text(
          'Category: $categories',
          style: _subtitle,
        ),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Bookings(title)));
        },
      ),
      new Container(
        padding: EdgeInsets.only(
            right: SizeConfig.safeBlockHorizontal * 3,
            left: SizeConfig.safeBlockHorizontal * 3),
        child: new Divider(
          thickness: 0.7,
        ),
      )
    ],
  );
}

Widget profilePhoto(BuildContext context, int i) {
  return new Container(
    child: new GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Details(i);
          }));
        },
        child: new Hero(
          tag: i,
          child: new CircleAvatar(
            radius: SizeConfig.blockSizeVertical * 4,
            backgroundColor: Colors.grey[300],
            child: FlutterLogo(
              size: SizeConfig.blockSizeVertical * 5,
            ),
          ),
        )),
  );
}

class Details extends StatelessWidget {
  int index;
  Details(int i) {
    index = i;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragDown: (DragDownDetails dragDownDetails) {
          Navigator.pop(context);
        },
        child: Center(
            child: new Container(
          height: SizeConfig.blockSizeVertical * 40,
          width: SizeConfig.blockSizeHorizontal * 90,
          color: Colors.white,
          child: Hero(
            tag: index,
            child: FlutterLogo(),
          ),
        )),
      ),
    );
  }
}
