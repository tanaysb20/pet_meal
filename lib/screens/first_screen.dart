import 'package:demo_app/screens/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: SizedBox(
              width: 200.w,
              height: 40.h,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff3E8B3A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return CameraScreen();
                      },
                    ));
                  },
                  child: Text(
                    "Share your meal",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Andika",
                        fontWeight: FontWeight.w400,
                        fontSize: 19.sp),
                  )),
            ),
          ),
          SizedBox(height: 92.h),
        ],
      ),
    );
  }
}
