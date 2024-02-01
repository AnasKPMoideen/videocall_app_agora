import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/google_signin_controller.dart';

class SignIn extends StatelessWidget {
  final GoogleSignInController _googleSignInController =
  Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _googleSignInController.signInWithGoogle();
          },
          child: Text('Sign In with Google'),
        ),
      ),
    );
  }
}




// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/route_manager.dart';
// import '../constant/app-constant.dart';
// import '../controller/google_signin_controller.dart';
//
//
// class SignIn extends StatefulWidget {
//   const SignIn({super.key});
//
//   @override
//   State<SignIn> createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
//   final _formKey = GlobalKey<FormState>();
//   final GoogleSignInController _googleSignInController = Get.put(GoogleSignInController());
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppConstant.appScendoryColor,
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           backgroundColor: AppConstant.appScendoryColor,
//           elevation: 0,
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           child: SizedBox(
//             width: Get.width,
//             height: Get.height,
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(top: 50.0).w,
//                     width: MediaQuery.of(context).size.width,
//                     child: Column(children: [
//                       Text(
//                         'Login here',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppConstant.yellowText,
//                           fontSize: 30.sp,
//                           fontFamily: 'Roboto-Bold',
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       const Text(
//                         'Welcome back you’ve been missed!',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontFamily: 'Roboto-Regular',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ]),
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: Form(
//                         key: _formKey,
//                         child: SizedBox(
//                           width: 323.w,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height: 15.h,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     margin: const EdgeInsets.only(bottom: 90.0).w,
//                     width: MediaQuery.of(context).size.width,
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               _googleSignInController.signInWithGoogle();
//                             },
//                             child: SizedBox(
//                               width: 60.w,
//                               height: 44.h,
//                               child: SvgPicture.asset(
//                                   'assets/images/flat-color-icons_google.svg'),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10.w,
//                           ),
//                         ]),
//                   ),
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
// }