import 'package:flutter/material.dart';
import 'package:prizey_vendor/main.dart';
import 'package:prizey_vendor/models/categoriesModel.dart';
import 'package:prizey_vendor/services/userServices.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';
import 'package:provider/provider.dart';

class SelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  List<String> categoriesTitle = List<String>();
  List<String> selectedCategories = List<String>();
  List<bool> _value = List<bool>();

  @override
  Widget build(BuildContext context) {
    UserAuth service = Provider.of<UserAuth>(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(
                  right: SizeConfig.safeBlockHorizontal * 70,
                  top: SizeConfig.safeBlockVertical * 5.5),
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
            Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.safeBlockVertical * 5,
              ),
              child: Text(
                'Apply to be a vendor',
                style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 5,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 1,
              ),
              child: Text(
                'Select categories :',
                style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 5),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.safeBlockVertical * 3,
                    left: SizeConfig.safeBlockHorizontal * 3,
                    right: SizeConfig.safeBlockHorizontal * 3,
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: FutureBuilder<List<CategoriesModel>>(
                      future: service.getCategories(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CategoriesModel>> snapshot) {
                        if (snapshot.hasData) {
                          return new GridView.builder(
                              itemCount: snapshot.data.length,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int i) {
                                String categoryName = snapshot.data[i].name;
                                categoriesTitle.add(categoryName);
                                _value.add(false);
                                String categoryId = snapshot.data[i].id;
                                String imageUrl = snapshot.data[i].imageUrl;
                                return _categories(i, categoryId, imageUrl);
                              });
                        }
                        return Center(child: CircularProgressIndicator());
                      })),
            ),
            Text(service.detailsPageMsg, style: TextStyle(color: Colors.red)),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            Expanded(
              flex: 1,
              child: new Container(
                margin:
                    EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 3),
                height: SizeConfig.blockSizeVertical * 5.5,
                child: new RaisedButton(
                  onPressed: () async {
                    bool userCreated =
                        await service.createUser(selectedCategories);
                    if (userCreated) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MyApp()),
                          ModalRoute.withName(''));
                      print('Singed Up');
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.green,
                  elevation: 0,
                  child: new Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 20,
                        right: SizeConfig.safeBlockHorizontal * 20),
                    child: new Text(
                      'Finish',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.safeBlockHorizontal * 5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categories(int i, String categoryId, String imageUrl) {
    return new Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey),
      margin: EdgeInsets.all(5),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: Colors.grey,
            ),
            margin: EdgeInsets.only(
              top: 145,
            ),
            padding: EdgeInsets.only(top: 0),
            child: CheckboxListTile(
                value: _value[i],
                title: new Text(
                  categoriesTitle[i],
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onChanged: (val) {
                  setState(() {
                    _value[i] = val;
                    if (val) {
                      selectedCategories.add(categoryId);
                    } else {
                      selectedCategories.remove(categoryId);
                    }
                  });
                }),
          ),
        ],
      ),
    );
  }
}
