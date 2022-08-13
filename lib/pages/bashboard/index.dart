import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'controller.dart';
import 'package:flutter_hello_ethereum/common/contract/contract_linking.dart';

class DashBoardPage extends GetView<DashBoardController> {
  const DashBoardPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // Getting the value and object or contract_linking
    var contractLink = Provider.of<ContractLinking>(context);

    TextEditingController yourNameController = TextEditingController();

    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Hello World !"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: contractLink.isLoading
                ? CircularProgressIndicator()
                : SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hello ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 52),
                        ),
                        Text(
                          contractLink.deployedName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 52,
                              color: Colors.tealAccent),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 29),
                      child: TextFormField(
                        controller: yourNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Your Name",
                            hintText: "What is your name ?",
                            icon: Icon(Icons.drive_file_rename_outline)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                        child: Text(
                          'Set Name',
                          style: TextStyle(fontSize: 30),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        onPressed: () {
                          contractLink.setName(yourNameController.text);
                          yourNameController.clear();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
