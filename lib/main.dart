import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inherit_vs_getx/getx/getx_app.dart';
import 'package:inherit_vs_getx/inherit/inherited_model_app.dart';
import 'package:inherit_vs_getx/inherit/inherited_notifier_app.dart';
import 'package:inherit_vs_getx/inherit/inherited_widget_app.dart';

void main() {
  print("main");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("bulid MyApp");
    return GetMaterialApp(
      getPages: [
        GetPage(name: "/getx_app", page: () => const GetxApp()),
        GetPage(name: "/inherited_widget_app", page: () => const InheritedWidgetApp()),
        GetPage(name: "/inherited_model_app", page: () => const InheritedModelApp()),
        GetPage(name: "/inherited_notifier_app", page: () => const InheritedNotifierApp()),
      ],
      initialRoute: "/inherited_notifier_app",
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
