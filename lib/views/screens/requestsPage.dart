import 'package:flutter/material.dart';
import 'package:prizey_vendor/models/productsModel.dart';
import 'package:prizey_vendor/models/queryModel.dart';
import 'package:prizey_vendor/services/userServices.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';
import 'bookings.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  UserAuth queryService;

  @override
  void initState() {
    queryService = UserAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 1),
            child: FutureBuilder<List<QueryModel>>(
                future: queryService.getQueries(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<QueryModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        String productId = snapshot.data[i].productId;
                        String queryId = snapshot.data[i].queryId;
                        String categoryId = snapshot.data[i].categoryId;
                        return QueryDetails(
                          productId: productId,
                          categoryId: categoryId,
                          queryId: queryId,
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })));
  }
}

class QueryDetails extends StatefulWidget {
  String productId, categoryId, queryId;
  QueryDetails({this.productId, this.categoryId, this.queryId});
  @override
  _QueryDetailsState createState() => _QueryDetailsState();
}

class _QueryDetailsState extends State<QueryDetails> {
  UserAuth productContent;

  @override
  void initState() {
    productContent = UserAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder<ProductsModel>(
              future: productContent.getQueryProduct(widget.productId),
              builder: (context, AsyncSnapshot<ProductsModel> snapshot) {
                String productName = snapshot.data.name;
                String features = snapshot.data.features;
                String imageUrl = snapshot.data.imageUrl;
                return new ListTile(
                  leading: productPicture(imageUrl),
                  title: new Container(
                    child: Text(
                      '$productName',
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  // subtitle: new Text(
                  //   'Category: $categories',
                  //   style: _subtitle,{snapshot.data.name}
                  // ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Bookings(
                              productName: productName,
                              features: features,
                              imageUrl: imageUrl,
                              queryId: widget.queryId,
                            )));
                  },
                );
              }),
          new Container(
            padding: EdgeInsets.only(
                right: SizeConfig.safeBlockHorizontal * 3,
                left: SizeConfig.safeBlockHorizontal * 3),
            child: new Divider(
              thickness: 0.7,
            ),
          )
        ],
      ),
    );
  }

  Widget productPicture(String imageUrl) {
    return new Container(
      child: new CircleAvatar(
        radius: SizeConfig.blockSizeVertical * 4,
        backgroundColor: Colors.grey[300],
        child: FlutterLogo(
          size: SizeConfig.blockSizeVertical * 5,
        ),
      ),
    );
  }
}
