import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodJobScreen extends StatelessWidget {
  const GoodJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "GOOD JOB",
              style: TextStyle(
                  color: Color(0xff3E8B3A),
                  fontFamily: "Andika-Bold",
                  height: 1.5,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  fontSize: 40.sp),
            ),
          ],
        ),
      ),
    );
  }
}
