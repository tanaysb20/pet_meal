import 'dart:io';

import 'package:demo_app/screens/good_job.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  bool loading = true;
  String txfileName = '';
  File? storedImage;
  XFile? sadass;
  bool check = false;
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    asda().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  Future asda() async {
    final cameras = await availableCameras();

    // Select a camera (e.g., the first one)

    controller = CameraController(cameras[0], ResolutionPreset.medium);

    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future captureImage() async {
    if (controller!.value.isInitialized) {
      print("step 1");
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = extDir.path;
      print("step 2");
      await Directory(dirPath).create(recursive: true);

      print("step 3");

      try {
        final sada = await controller!.takePicture();
        print("step 4");
        sadass = sada;
      } on CameraException catch (e) {
        print(e);
        print("step error");
        setState(() {});
        return null;
      }
      print("step 5");
      storedImage = File(sadass!.path);
      print("step 6");
      txfileName = sadass!.path;
      check = true;
      setState(() {});
      print("step 7");
    }
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child('images/${sadass!.name}')
          .putFile(imageFile);
      EasyLoading.showToast("Thank you for sharing food with me",
          maskType: EasyLoadingMaskType.black);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('$txfileName txfileName');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10.w),
                        child: ClipOval(
                          child: Container(
                              color: Color(0xff3E8B3A),
                              height: 33.h,
                              width: 40.w,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.h),
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/tiger.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 27.w),
                      height: 432.h,
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          color: Color(0xffF4F4F4),
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0),
                          )),
                      child: Column(
                        children: [
                          SizedBox(height: 50.h),
                          Row(
                            children: [
                              Container(
                                width: 28.w,
                                height: 160.h,
                                child: Image.asset(
                                  "assets/fork.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Spacer(),
                              Stack(
                                children: [
                                  Container(
                                    height: 170.h,
                                    width: 170.h,
                                    child: Image.asset(
                                      "assets/frame.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  storedImage == null
                                      ? Positioned(
                                          left: 10.w,
                                          child: ClipOval(
                                              child: Container(
                                                  height: 160.h,
                                                  width: 180.w,
                                                  child: CameraPreview(
                                                      controller!))))
                                      : Container(
                                          height: 170.h,
                                          width: 170.h,
                                          alignment: Alignment.center,
                                          child: CircleAvatar(
                                            radius: 90,
                                            backgroundImage:
                                                FileImage(storedImage!),
                                          ),
                                        )
                                ],
                              ),
                              Spacer(),
                              Container(
                                width: 28.w,
                                height: 160.h,
                                child: Image.asset(
                                  "assets/spoon.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          Text(
                            check ? "Will you eat this?" : "Click your meal",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Andika",
                                fontWeight: FontWeight.w400,
                                fontSize: 19.sp),
                          ),
                          SizedBox(height: 20.h),
                          InkWell(
                            onTap: check
                                ? () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    await uploadImage(storedImage!);
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return GoodJobScreen();
                                      },
                                    ));
                                  }
                                : () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    await captureImage();
                                    setState(() {
                                      loading = false;
                                    });
                                  },
                            child: check
                                ? Image.asset(
                                    "assets/yes.png",
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/camera.png",
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
      ),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
