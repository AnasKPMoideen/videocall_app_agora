import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/google_signin_controller.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({Key? key}) : super(key: key);

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final GoogleSignInController _googleSignInController =
  Get.put(GoogleSignInController());
  User? user = FirebaseAuth.instance.currentUser;

  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "27d4dce9ace847df8733494f0387f29a",
      channelName: "video_call_agora",
      tempToken: '007eJxTYNi8337O2tVCu4uznKT/TlzYJXr4p0HOzhMMxp1FT26qZm5RYDAyTzFJSU61TExOtTAxT0mzMDc2NrE0STMwtjBPM7JM/M2+L7UhkJGB52o4EyMDBIL4AgxlmSmp+fHJiTk58Ynp+UWJDAwAT7UlLw==',
    ),
    enabledPermission: [Permission.camera, Permission.microphone],
  );

  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // actions: [
          //   // Add user's name to the app bar
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: CircleAvatar(
          //       backgroundImage: NetworkImage('user!.photoURL.toString()'), // Replace with the actual profile image URL
          //     ),
          //   ),
          // ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
                layoutType: Layout.floating,
                floatingLayoutContainerHeight: 100,
                floatingLayoutContainerWidth: 100,
                showNumberOfUsers: true,
                showAVState: true,
              ),
              AgoraVideoButtons(
                client: client,
                enabledButtons: [
                  BuiltInButtons.toggleMic,
                  BuiltInButtons.callEnd,
                  BuiltInButtons.switchCamera
                ],
                extraButtons: [
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible; // Corrected line to toggle visibility
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isVisible ? Colors.white : Colors.blue,
                      ),
                      child: isVisible
                          ? Icon(
                        Icons.visibility,
                        color: Colors.blue,
                        size: 20,
                      )
                          : Icon(
                        Icons.visibility_off,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
