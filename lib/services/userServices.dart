import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:prizey_vendor/models/categoriesModel.dart';
import 'package:prizey_vendor/models/productsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserAuth with ChangeNotifier {
  SharedPreferences sharedPreferences;
  String url = 'http://13.232.214.36:7777';
  String token,
      sendOtpStatus,
      verifyOtpStatus,
      userStatus,
      sendOtpMsg = '',
      verifyOtpMsg = '',
      detailsPageMsg = '';
  var userDetails;

  Future<bool> sendOtp(String phoneNumber) async {
    String sendOtpUrl = '$url' + '/api/auth/sendotp';
    try {
      if (phoneNumber.isNotEmpty) {
        http.Response response = await http.post(sendOtpUrl,
            body: {'mobile': phoneNumber, 'medium': 'SMS', 'type': 'Vendor'});
        var data = json.decode(response.body);
        print("Get Send Otp Request:");
        print(data);
        if (data != null) {
          sendOtpStatus = data['status'];
          print('send-otp status : $sendOtpStatus');
          token = data['token'];
          await addTokenToSP(token);
        }
        // print('Send OTP method: ' + data.toString());
      } else {
        sendOtpMsg = 'Above Field can\'t be empty';
      }
      notifyListeners();
      if (sendOtpStatus == 'Success') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    String verifyOtpUrl = '$url' + '/api/auth/verifyotp';
    try {
      if (otp.isNotEmpty) {
        token = await getTokenFromSP();
        http.Response response = await http.post(
          verifyOtpUrl,
          headers: <String, String>{'Authorization': 'jwt ' + token},
          body: {'otp': otp, 'medium': 'SMS'},
        );
        var data = json.decode(response.body);
        print("Get Verify OTP Request: ");
        print(data);
        if (data != null) {
          verifyOtpStatus = data['status'];
          print('verify-otp status : $verifyOtpStatus');
          token = data['token'];
          await addTokenToSP(token);
        }
        // print('Verify OTP method: ' + data);
      } else {
        verifyOtpMsg = 'Above Field can\'t be empty';
      }
      notifyListeners();
      if (verifyOtpStatus == 'Success') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getRegisteredUser() async {
    String checkPhoneUrl = '$url' + '/api/user/getuser';
    try {
      token = await getTokenFromSP();
      http.Response response = await http.get(checkPhoneUrl,
          headers: <String, String>{'Authorization': 'jwt ' + token});
      var data = json.decode(response.body);
      print("Get Registered User: ");
      print(data);
      if (data != null) {
        userStatus = data['status'];
        print('user status : $userStatus');
        userDetails = data['user'];
        token = data['token'];
      }
      notifyListeners();
      // print('Get registered method: ' + data);
      if (userStatus == 'Success') {
        await addTokenToSP(token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getUserProfile() async {
    String profileFetchingUrl = '$url' + '/api/user/profile';
    try {
      token = await getTokenFromSP();
      http.Response response = await http.post(profileFetchingUrl,
          headers: <String, String>{'Authorization': 'jwt ' + token},
          body: {'type': 'Customer'});
      var data = json.decode(response.body);
      if (data != null) {
        userStatus = data['status'];
        print('user status : $userStatus');
        userDetails = data['user'];
        await addTokenToSP(token);
      }
      notifyListeners();
      // print('Get user profile method : ' + data);
      if (userStatus == 'Success') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  String firstName, lastName, address;

  Future<bool> createUser(List<String> categoryId) async {
    String addUserUrl = '$url' + '/api/user/adduser';
    try {
      if (categoryId.isNotEmpty && categoryId != null) {
        token = await getTokenFromSP();
        print("Asked to create new User:");
        print(token);
        print('token : $token');
        var categories = json.encode(categoryId);
        http.Response response = await http.post(
          addUserUrl,
          headers: <String, String>{
            'Authorization': 'jwt ' + token,
            'Content-type': 'application/json'
          },
          body: {
            'type': 'Vendor',
            'token': 'Firebase Token',
            'firstName': firstName,
            'lastName': lastName,
            'address': address,
            'categories': categories,
          },
        );
        var data = json.decode(response.body);
        print("Create User Request: ");
        print(data);
        if (data != null) {
          userStatus = data['status'];
          print('user status : $userStatus');
          userDetails = data['user'];
          token = data['token'];
          await addTokenToSP(token);
        }
        // print('Create new user method: ' + data);
      } else {
        detailsPageMsg = 'Select atleast one category first';
      }
      notifyListeners();
      if (userStatus == 'Success') {
        await addUserStatusToSP();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  addTokenToSP(String token) async {
    print("Add Token: $token");
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setString('token', token);
  }

  getTokenFromSP() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    String _token = sharedPreferences.getString('token');
    print("Get Token: $_token");
    return _token;
  }

  addUserStatusToSP() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setBool('userExist', true);
  }

  getUserStatusFromSP() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    bool _status = sharedPreferences.getBool('userExist');
    return _status;
  }

  String getCategoriesStatus, getProdeuctsStatus;

  Future<List<CategoriesModel>> getCategories() async {
    String categoryUrl = url + '/api/category/list';
    List<CategoriesModel> categoriesList = List<CategoriesModel>();
    try {
      http.Response response =
          await http.get(categoryUrl, headers: <String, String>{});
      var data = json.decode(response.body);
      List _categories;
      _categories = data['catgories'] as List;
      for (var i in _categories) {
        CategoriesModel category = CategoriesModel(
            id: i['_id'], name: i['name'], imageUrl: i['image_url']);
        categoriesList.add(category);
      }
      // noOfCategories = data['count'];
      getCategoriesStatus = data['status'];
      // notifyListeners();
      // print('Categories list(auth): $categoriesList');
    } catch (e) {
      print(e);
    }
    return categoriesList;
  }

//   Future<List<ProductsModel>> getProducts(String categoryId) async {
//     String categoryUrl = url + '/api/product/incategory?limit=5&id=$categoryId';
//     List<ProductsModel> productsList = List<ProductsModel>();
//     try {
//       token = await getTokenFromSP();
//       // token =
//       //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlODlkMDJlNjRjM2NkMDYyMDE3OGQ0NyIsInR5cGUiOiJWZW5kb3IiLCJpYXQiOjE1ODYwOTAwMzB9.dXS0ykz14NgATxBxgcCtHA2lYHJF2ss60JO-PlqtZkQ';
//       http.Response response =
//           await http.get(categoryUrl, headers: <String, String>{
//         'Authorization': 'jwt ' + token
//         // 'Authorization': 'jwt ' + _auth.token
//       });
//       var data = json.decode(response.body);
//       print(data);
//       List _products;
//       _products = data['products'] as List;
//       for (var i in _products) {
//         ProductsModel product = ProductsModel(
//             id: i['_id'], name: i['name'], imageUrl: i['image_url']);
//         productsList.add(product);
//       }
//       getProdeuctsStatus = data['status'];
//       print(getProdeuctsStatus);
//       print(productsList[0].name);
//     } catch (e) {
//       print(e);
//     }
//     return productsList;
//   }
}
