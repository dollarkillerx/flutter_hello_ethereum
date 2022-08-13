import 'package:flutter/material.dart';
import 'package:flutter_hello_ethereum/common/contract/contract_linking.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'common/routes/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
        create: (_) => ContractLinking(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.MainPage,
        getPages: AppPages.routes,
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.cyan[400],
            accentColor: Colors.deepOrange[200]),
        unknownRoute: AppPages.unknownRoute,
      ),
    );
  }
}


