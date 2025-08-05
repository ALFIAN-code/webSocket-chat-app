import 'package:client/getx/global_cotroller.dart';
import 'package:client/screen/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleSelectorPage extends StatelessWidget {
  RoleSelectorPage({super.key});

  var controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191929),
      body: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 70),
          decoration: BoxDecoration(
            color: Color(0xff262641),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text(
                'Select Your Role',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff7825D5),
                  ),
                  onPressed: () {
                    controller.selectRole(UserRole.user1);
                    Get.to(() => Chatpage());
                  },
                  child: Text('User 1', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff7825D5),
                  ),
                  onPressed: () {
                    // Handle user role selection
                    controller.selectRole(UserRole.user2);
                    Get.to(() => Chatpage());
                  },
                  child: Text('User 2', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
