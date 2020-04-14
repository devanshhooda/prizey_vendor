import 'package:flutter/material.dart';
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
  // List<String> categoriesTitle = ['Laptop', 'Mattress', 'Electronics', 'Food'];
  List<String> selectedCategories = List<String>();
  // List<String> selectedCategories = [];
  List<bool> _value = List<bool>();
  // List<bool> _value = [false, false, false, false];

  String errorMsg = "";

  void detectError() {
    setState(() {
      errorMsg = "Above field can't be empty";
    });
  }

  @override
  Widget build(BuildContext context) {
    UserAuth content = Provider.of<UserAuth>(context, listen: false);
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
                  top: SizeConfig.safeBlockVertical * 5),
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
                // left: SizeConfig.safeBlockHorizontal * 20
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
                // left: SizeConfig.safeBlockHorizontal * 25
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
                  // padding: EdgeInsets.only(
                  //   left: SizeConfig.safeBlockHorizontal * 5,
                  // ),
                  decoration: BoxDecoration(
                      // color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)),
                  // child: new GridView.builder(
                  //     itemCount: 4,
                  //     gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 2),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       // _value.add(false);
                  //       return categories(index);
                  //     }),
                  child: FutureBuilder<List<CategoriesModel>>(
                      future: content.getCategories(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CategoriesModel>> snapshot) {
                        if (snapshot.hasData) {
                          return new GridView.builder(
                              itemCount: snapshot.data.length,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int i) {
                                _value.add(false);
                                String categoryName = snapshot.data[i].name;
                                categoriesTitle.add(categoryName);
                                _value.add(false);
                                String categoryId = snapshot.data[i].id;
                                String imageUrl = snapshot.data[i].imageUrl;
                                return _categories(i, categoryId, imageUrl);
                              });
                        }
                        return Center(child: CircularProgressIndicator());
                      })
                  // child: FutureBuilder<List<CategoriesModel>>(
                  //     future: content.getCategories(),
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<List<CategoriesModel>> snapshot) {
                  //       if (snapshot.hasData) {
                  //         return ListView.builder(
                  //             shrinkWrap: true,
                  //             itemCount: snapshot.data.length,
                  //             itemBuilder: (context, i) {
                  //               String categoryName = snapshot.data[i].name;
                  // categoriesTitle.add(categoryName);
                  // _value.add(false);
                  // String categoryId = snapshot.data[i].id;
                  //               return _categories(i, categoryId);
                  //             });
                  //       }
                  //       return Center(child: CircularProgressIndicator());
                  //     })
                  // child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: <Widget>[
                  //     _categories(0),
                  //     _categories(1),
                  //     _categories(2),
                  //     _categories(3),
                  //   ],
                  // ),
                  // child: ListView.builder(
                  //     itemCount: 4,
                  //     itemBuilder: (context, i) {
                  //       return categories(i);
                  //     }),
                  ),
            ),
            // Text(errorMsg, style: TextStyle(color: Colors.red)),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            Expanded(
              flex: 1,
              child: new Container(
                margin:
                    EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 3),
                height: SizeConfig.blockSizeVertical * 5.5,
                // padding: EdgeInsets.only(
                //     left: SizeConfig.safeBlockHorizontal * 25,
                //     right: SizeConfig.safeBlockHorizontal * 25),
                child: new RaisedButton(
                  onPressed: () {
                    // if (_address.text.isNotEmpty &&
                    //     selectedCategories.isNotEmpty) {
                    print('HomePage Screen');
                    //   Navigator.of(context).push(
                    //       MaterialPageRoute(builder: (context) => Password()));
                    // } else {
                    //   detectError();
                    // }
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
      margin: EdgeInsets.all(5),
      color: Colors.black12,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // FlutterLogo(
          //   size: 100,
          // ),
          Image.network(
            imageUrl,
            fit: BoxFit.fill,
          ),
          CheckboxListTile(
              value: _value[i],
              title: new Text(categoriesTitle[i]),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (val) {
                setState(() {
                  _value[i] = val;
                  if (val) {
                    selectedCategories.add(categoryId);
                  } else {
                    selectedCategories.remove(categoryId);
                  }
                });
              })
        ],
      ),
    );
  }

  // Widget categories(int i) {
  //   return new Container(
  //     margin: EdgeInsets.all(5),
  //     color: Colors.black12,
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: <Widget>[
  //         FlutterLogo(
  //           size: 100,
  //         ),
  //         CheckboxListTile(
  //             value: _value[i],
  //             title: new Text(categoriesTitle[i]),
  //             controlAffinity: ListTileControlAffinity.leading,
  //             onChanged: (val) {
  //               setState(() {
  //                 _value[i] = val;
  //                 if (val) {
  //                   selectedCategories.add(categoriesTitle[i]);
  //                 } else {
  //                   selectedCategories.remove(categoriesTitle[i]);
  //                 }
  //               });
  //             })
  //       ],
  //     ),
  //   );
  // }
}
