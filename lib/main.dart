import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prizey_vendor/services/userServices.dart';
import 'package:prizey_vendor/views/screens/options.dart';
import 'package:prizey_vendor/views/screens/selectCategoryPage.dart';
import 'package:provider/provider.dart';
import 'utils/sizeConfig.dart';
import 'views/appBar.dart';
import 'views/screens/enterDetails.dart';
import 'views/screens/loginPage.dart';
import 'views/screens/numberSignUp.dart';
import 'views/screens/profilePage.dart';
import 'views/screens/requestsPage.dart';
import 'views/screens/signUpOtp.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(PrizeyVendorApp());
}

class PrizeyVendorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAuth>(
          create: (context) => UserAuth(),
          child: LoginCheck(),
        ),
        ChangeNotifierProvider<UserAuth>(
          create: (context) => UserAuth(),
          child: PhoneNumber(),
        ),
        ChangeNotifierProvider<UserAuth>(
          create: (context) => UserAuth(),
          child: Password(),
        ),
        ChangeNotifierProvider<UserAuth>(
          create: (context) => UserAuth(),
          child: NameSignUp(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserAuth(),
          child: SelectCategory(),
        ),
        ChangeNotifierProvider<UserAuth>(
          create: (context) => UserAuth(),
          child: LoginPage(),
        ),
      ],
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: Colors.indigoAccent,
        ),
        home: LoginCheck(),
        // home: SelectCategory(),
      ),
    );
  }
}

class LoginCheck extends StatefulWidget {
  @override
  _LoginCheckState createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    UserAuth _auth = Provider.of<UserAuth>(context);
    return FutureBuilder(
        future: _auth.getUserStatusFromSP(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return MyApp();
          } else {
            return OptionsPage();
          }
        });
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> pages = [
      Tab(
        icon: Icon(Icons.mobile_screen_share),
      ),
      Tab(
        icon: Icon(Icons.person),
      ),
    ];

    SizeConfig().init(context);

    TabController controller = TabController(length: 2, vsync: this);

    return new Scaffold(
      appBar: app_Bar(context),
      bottomNavigationBar: Material(
        color: Colors.indigo,
        child: TabBar(
          tabs: pages,
          controller: controller,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        children: <Widget>[Requests(), ProfilePage()],
        controller: controller,
      ),
    );
  }
}
