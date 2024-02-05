import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_call_app_agora/constant/app-constant.dart';
import '../controller/google_signin_controller.dart';

class SignIn extends StatelessWidget {
  final GoogleSignInController _googleSignInController =
  Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Make the body extend behind the app bar
      appBar: AppBar(
        title: Center(
          child: Text(
            'Sign In',
            style: TextStyle(
              color: Colors.white, // Set text color for app bar title
            ),
          ),
        ),
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove the shadow
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image (SVG)
          SvgPicture.asset(
            'assets/images/background.svg',
            fit: BoxFit.cover,
          ),
          // Glass Effect Container
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3), // Adjust the opacity as needed
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Adjust the blur intensity
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Center(
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: AppConstant.appTextColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: Text(
                    'Hey, Lets join together',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppConstant.appStatusBarColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await _googleSignInController.signInWithGoogle();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Google Logo (SVG)
                          SvgPicture.asset(
                            'assets/images/flat-color-icons_google.svg',
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
