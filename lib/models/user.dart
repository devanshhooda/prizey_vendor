import 'package:flutter/cupertino.dart';

abstract class UserUtil {
  @required
  String name;
  @required
  String phoneNo;

  String address;
  Image profileImage;

  UserUtil({this.name, this.phoneNo, this.address, this.profileImage});
}
