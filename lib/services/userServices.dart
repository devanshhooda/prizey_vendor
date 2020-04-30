import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:prizey_vendor/data/database.dart';
import 'package:prizey_vendor/models/categoriesModel.dart';
import 'package:prizey_vendor/models/productsModel.dart';
import 'package:prizey_vendor/models/queryModel.dart';
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
        // print("Get Send Otp Request:");
        // print(data);
        if (data != null) {
          sendOtpStatus = data['status'];
          // print('send-otp status : $sendOtpStatus');
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
        // print("Get Verify OTP Request: ");
        // print(data);
        if (data != null) {
          verifyOtpStatus = data['status'];
          // print('verify-otp status : $verifyOtpStatus');
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
      // print("Get Registered User: ");
      // print(data);
      if (data != null) {
        userStatus = data['status'];
        // print('user status : $userStatus');
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
        // print("Asked to create new User:");
        // print(token);
        // print('firebase token : $firebaseToken');
        // print('token : $token');
        var body = json.encode({
          'type': 'Vendor',
          'token': firebaseToken,
          'firstName': firstName,
          'lastName': lastName,
          'address': address,
          'categories': categoryId
        });
        http.Response response = await http.post(addUserUrl,
            headers: <String, String>{
              'Authorization': 'jwt ' + token,
              'Content-type': 'application/json'
            },
            body: body);
        var data = json.decode(response.body);
        // print("Create User Request: ");
        // print(data);
        if (data != null) {
          userStatus = data['status'];
          // print('user status : $userStatus');
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
    // print("Add Token: $token");
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
    firebaseToken = await firebaseMessaging.getToken();
    // print('fcm token : $firebaseToken');
    // print("Get Token: $_token");
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

  String getCategoriesStatus, getProdeuctsStatus, getQueyProductStatus;

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

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  String firebaseToken;

  DatabaseHelper databaseHelper = new DatabaseHelper(); // database handler

  UserAuth() {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        onReceiveQuery(message);
        print('onMessage : $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch : $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume : $message');
      },
    );
  }

  Future onReceiveQuery(var query) async {
    try {
      QueryModel queryModel = QueryModel(
          queryId: query['query_id'],
          productId: query['product_id'],
          categoryId: query['category_id'],
          productName: query['productName']);
      var databaseResult = await databaseHelper.insertQuery(queryModel);
      print('inserQuery : $databaseResult');
    } catch (e) {
      print(e);
    }
  }

  Future<List<QueryModel>> getQueries() async {
    try {
      List<QueryModel> queriesList = await databaseHelper.getQueriesList();
      return queriesList;
    } catch (e) {
      print(e);
    }
  }

  Future<ProductsModel> getQueryProduct(String productId) async {
    String productsUrl = url + '/api/product/details?id=$productId';
    ProductsModel product;
    // print('product id : $productId');
    try {
      token = await getTokenFromSP();
      http.Response response = await http.get(productsUrl,
          headers: <String, String>{'Authorization': 'jwt ' + token});
      var data = json.decode(response.body);
      // print('product data : $data');
      product = ProductsModel(
        id: data['product']['_id'],
        name: data['product']['name'],
        imageUrl: data['product']['image_url'],
        features: data['product']['features'],
        // categoryId: data['products']['category'][0],
      );
      getQueyProductStatus = data['status'];
      notifyListeners();
    } catch (e) {
      print(e);
    }
    // print('product : $product');
    return product;
  }

  String responseQueryMessage = '';

  Future<bool> respondQuery(
      String queryId, String price, String message) async {
    try {
      String respondQueryUrl = url + '/api/query/reply';
      token = await getTokenFromSP();
      http.Response response =
          await http.post(respondQueryUrl, headers: <String, String>{
        'Authorization': 'jwt ' + token,
      }, body: {
        'query': queryId,
        'price': price,
        'message': message
      });
      var data = json.decode(response.body);

      String responseQueryStatus = data['status'];
      responseQueryMessage = data['message'];
      if (responseQueryStatus == 'Success') {
        notifyListeners();
        var databaseResult = databaseHelper.deleteQuery(queryId);
        print('deleteQuery : $databaseResult');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
