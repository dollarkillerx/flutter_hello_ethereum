import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class DashBoardPage extends GetView<DashBoardController> {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(title: Text("AppBar"),),
        body: Center(
          child: Text("Home"),
        ),
      );
    });
  }
}

