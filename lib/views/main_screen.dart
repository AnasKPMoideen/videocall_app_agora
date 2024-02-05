import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_call_app_agora/constant/app-constant.dart';
import 'package:video_call_app_agora/views/video_call.dart';
import '../controller/google_signin_controller.dart';

class ContactModel {
  final String name;
  final String assetImagePath;

  ContactModel({required this.name, required this.assetImagePath});
}

class MainPage extends StatelessWidget {
  final GoogleSignInController _googleSignInController =
  Get.put(GoogleSignInController());
  User? user = FirebaseAuth.instance.currentUser;

  final List<ContactModel> contactModels = [
    ContactModel(name: 'Leo Leo', assetImagePath: 'assets/images/person1.jpg'),
    ContactModel(name: 'Eden Hazard', assetImagePath: 'assets/images/person2.jpg'),
    ContactModel(name: 'Angel Guardian', assetImagePath: 'assets/images/person2.jpg'),
    ContactModel(name: 'Leo Das', assetImagePath: 'assets/images/person1.jpg'),
    // Add more contact models as needed
  ];

  final List<String> carouselImages = [
    'assets/images/banner1.jpg',
    'assets/images/banner1.jpg',
    // Add more asset image paths as needed
  ];

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VidTalK', style: TextStyle(
          color: AppConstant.appMainColor
        ),),
        actions: [
          IconButton(
            onPressed: () async {
              await _googleSignInController.signOutGoogle();
            },
            icon: Icon(Icons.logout, color: Colors.red,),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: AppConstant.appStatusBarColor,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL.toString()),
                radius: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                user!.displayName.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                user!.email.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, // Change color as needed
                      width: 0.5, // Change width as needed
                    ),
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust spacing as needed
                  leading: Icon(Icons.video_call),
                  title: Text(
                    'Start Video Call',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Get.to(() => VideoCall());
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, // Change color as needed
                      width: 0.5, // Change width as needed
                    ),
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust spacing as needed
                  leading: Icon(Icons.logout, color: Colors.red,),
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  onTap: () async {
                    await _googleSignInController.signOutGoogle();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Image with Glass Effect
          SvgPicture.asset(
            'assets/images/background.svg', // Replace with your SVG image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Glass Effect
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.white.withOpacity(0.3), // Adjust the opacity as needed
          //     borderRadius: BorderRadius.vertical(
          //       bottom: Radius.circular(20),
          //     ),
          //   ),
          // ),
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
            children: [
              SizedBox(height: 20),
              // Carousel Banner
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 2.0,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: carouselImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 50,
              ),
              // Contact Models
              Expanded(
                child: ListView.builder(
                  itemCount: contactModels.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(contactModels[index].name),
                            Row(
                              children: [
                                IgnorePointer(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey, // Adjust the color as needed
                                    child: Icon(Icons.call, color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => VideoCall());
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue, // Adjust the color as needed
                                    child: Icon(Icons.videocam, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            contactModels[index].assetImagePath,
                          ),
                          radius: 20, // Adjust the radius as needed
                        ),
                        // Add more details or actions for each contact as needed
                      ),
                    );
                  },
                ),
              ),
              // Video Call Button
              // ElevatedButton(
              //   onPressed: () {
              //     Get.to(() => VideoCall());
              //   },
              //   child: Text("Start Video Call"),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
