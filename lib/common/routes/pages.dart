import 'package:flutter_hello_ethereum/common/routes/routes.dart';
import 'package:flutter_hello_ethereum/pages/bashboard/binding.dart';
import 'package:get/get.dart';
import '../../pages/bashboard/index.dart';
import '../../pages/notfound/index.dart';

class AppPages {
  static const MainPage = AppRoutes.DashBoard;

  static final routes = [
    GetPage(
      name: AppRoutes.DashBoard,
      page: () => const DashBoardPage(),
      binding: DashBoardBinding(),
    )
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.NotFound,
    page: () => NotfoundView(),
  );
}
