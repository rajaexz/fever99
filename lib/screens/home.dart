import 'package:flutter/material.dart';
import 'landing.dart';
import 'user/login.dart';
import 'user/register.dart';
import '../common/services/utils.dart';
import '../support/app_theme.dart' as app_theme;
import '../common/widgets/common.dart';
import '../common/services/auth.dart' as auth;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuth();
  }

  Future<void> _navigateBasedOnAuth() async {
    await Future.delayed(const Duration(seconds: 3)); // Add 3-second delay
    await auth.fetchAuthInfo();
    if (auth.isLoggedIn()) {
      navigatePage(context, const LandingPage());
    } else {
      navigatePage(context, const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackgroundImage(),
          Padding(
            padding: EdgeInsets.only(
              top: 0,
              left: 32,
              right: 32,
              bottom: 0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppLogo(
                  height: 180,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Most awaited Dating App is here!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.0),
                      child: Text(
                        "Dating doesn't have to be hard.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: AppItemProgressIndicator(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
