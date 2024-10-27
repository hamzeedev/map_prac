import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_prac/map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(()=>  MapScreen());
              }, 
              child: const Text("Google Map"),
              ),
          ],
        ),
      ),
    );
  }
}