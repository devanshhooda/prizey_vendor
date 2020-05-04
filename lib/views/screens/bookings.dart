import 'package:flutter/material.dart';
import 'package:prizey_vendor/services/userServices.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';

import 'loginPage.dart';

class Bookings extends StatefulWidget {
  String productName, imageUrl, features, queryId;
  Bookings({this.productName, this.features, this.imageUrl, this.queryId});

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  UserAuth query;
  TextEditingController _price;
  TextEditingController _message;
  @override
  void initState() {
    query = UserAuth();
    _price = new TextEditingController();
    _message = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _price.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String price = '', message = '';
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
            (widget.productName != null && widget.productName.isNotEmpty)
                ? '${widget.productName}'
                : ''),
      ),
      body: new Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: new ListView(
          children: <Widget>[
            _productPortion(),

            // Here is the reply column
            // Expanded(
            //     flex: 5,
            // child:
            Container(
              child: Column(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 7,
                      right: SizeConfig.safeBlockHorizontal * 7,
                    ),
                    child: new Container(
                        height: SizeConfig.blockSizeVertical * 6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.black12),
                        padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 3,
                            top: SizeConfig.safeBlockHorizontal * 0.5),
                        child: new TextField(
                          // onChanged: (change) {
                          //   setState(() {
                          //     price += change;
                          //   });
                          // },
                          controller: _price,
                          style: inputTextStyle,
                          keyboardType: TextInputType.number,
                          cursorWidth: 2,
                          cursorColor: Colors.indigo,
                          decoration: InputDecoration(
                            hintText: 'Price',
                            hintStyle: hintStyle,
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.phone,
                              size: SizeConfig.safeBlockVertical * 3.5,
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  new Container(
                    padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 7,
                      right: SizeConfig.safeBlockHorizontal * 7,
                    ),
                    child: Container(
                      margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        minLines: 3,
                        maxLines: 5,
                        controller: _message,
                        decoration: InputDecoration(
                            hintText: 'Message(Optional)',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  _queryButton(context, query, widget.queryId)
                ],
              ),
              // )
            )
          ],
        ),
      ),
    );
  }

  Widget _productPortion() {
    return Container(
      child: Column(
        children: <Widget>[
          _itemPicture(widget.imageUrl),
          _itemDetails(widget.productName, widget.features),
          new Container(
            padding: EdgeInsets.only(
              left: SizeConfig.safeBlockHorizontal * 3,
              right: SizeConfig.safeBlockHorizontal * 3,
            ),
            child: Divider(
              thickness: 5,
              height: SizeConfig.blockSizeVertical * 3,
            ),
          ),
          // new Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: <Widget>[
          // _sortButton('Distance'),
          // _sortButton('Price'),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _itemPicture(String imageUrl) {
    return new Container(
      height: SizeConfig.blockSizeVertical * 15,
      padding: EdgeInsets.only(
          left: SizeConfig.safeBlockHorizontal * 2,
          right: SizeConfig.safeBlockHorizontal * 2,
          top: SizeConfig.safeBlockVertical * 1),
      child: new Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.contain)),
      ),
    );
  }

  Widget _itemDetails(String productName, String features) {
    return new Container(
      padding: EdgeInsets.only(
          left: SizeConfig.safeBlockHorizontal * 3,
          top: SizeConfig.safeBlockVertical * 1),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Text(
              (productName != null && productName.isNotEmpty)
                  ? productName
                  : '',
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                  fontWeight: FontWeight.bold),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 0.5),
            child: new Text(
              (features != null && features.isNotEmpty)
                  ? 'Features: $features'
                  : '',
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                  color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _sortButton(String sortingMethod) {
  //   return new Container(
  //     child: new FlatButton(
  //         onPressed: () {},
  //         child: new Row(
  //           children: <Widget>[
  //             Text(sortingMethod),
  //             Padding(
  //                 padding: EdgeInsets.only(
  //                     left: SizeConfig.blockSizeHorizontal * 1)),
  //             Icon(Icons.sort)
  //           ],
  //         )),
  //   );
  // }

  Widget _queryButton(BuildContext context, UserAuth query, String queryId) {
    String price, message;
    return Container(
      height: SizeConfig.blockSizeVertical * 5.5,
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.safeBlockVertical * 5,
          horizontal: SizeConfig.safeBlockHorizontal * 15),
      child: new RaisedButton(
        onPressed: () async {
          setState(() {
            price = _price.text;
            message = _message.text;
          });
          print('price button : $price');
          print('message button : $message');
          bool querySent = await query.respondQuery(queryId, price, message);
          if (querySent) {
            // This snackbar is not showing
            // Scaffold.of(context).showSnackBar(SnackBar(
            //   content: Text('Reply sent.. Thank you !'),
            //   duration: Duration(seconds: 3),
            // ));
            Navigator.of(context).pop();
            print('Reply Will be sent');
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        color: Colors.green,
        child: new Container(
          // padding: EdgeInsets.all(15),
          child: new Text(
            'Send Reply',
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.safeBlockHorizontal * 5),
          ),
        ),
      ),
    );
  }
}
