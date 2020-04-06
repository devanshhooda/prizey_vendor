import 'package:flutter/material.dart';
import 'package:prizey_vendor/utils/sizeConfig.dart';
import 'package:prizey_vendor/views/screens/signUpPass.dart';

List<String> selectedCategories = [];

class SelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  List categoriesTitle = ['Electronics', 'Medicines', 'Laptops', 'Mattress'];

  List<bool> _value = [false, false, false, false];

  TextEditingController _address = new TextEditingController();

  String errorMsg = "";

  void detectError() {
    setState(() {
      errorMsg = "Above field can't be empty";
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: ListView(
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
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 5,
                  left: SizeConfig.safeBlockHorizontal * 20),
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
                  left: SizeConfig.safeBlockHorizontal * 25),
              child: Text(
                'Select category :',
                style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 5),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.safeBlockVertical * 3,
                left: SizeConfig.safeBlockHorizontal * 20,
                right: SizeConfig.safeBlockHorizontal * 20,
              ),
              padding: EdgeInsets.only(
                left: SizeConfig.safeBlockHorizontal * 5,
              ),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _categories(0),
                  _categories(1),
                  _categories(2),
                  _categories(3),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                minLines: 3,
                maxLines: 5,
                controller: _address,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    hintText: 'Enter your address...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 30),
              child: Text(errorMsg, style: TextStyle(color: Colors.red)),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            new Container(
              height: SizeConfig.blockSizeVertical * 5.5,
              padding: EdgeInsets.only(
                  left: SizeConfig.safeBlockHorizontal * 60,
                  right: SizeConfig.safeBlockHorizontal * 5),
              child: new RaisedButton(
                onPressed: () {
                  if (_address.text.isNotEmpty &&
                      selectedCategories.isNotEmpty) {
                    print('Password Screen');
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Password()));
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
      ),
    );
  }

  Widget _categories(int i) {
    return new CheckboxListTile(
        value: _value[i],
        title: new Text(categoriesTitle[i]),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (val) {
          setState(() {
            _value[i] = val;
            if (val) {
              selectedCategories.add(categoriesTitle[i]);
            } else {
              selectedCategories.remove(categoriesTitle[i]);
            }
          });
        });
  }
}
