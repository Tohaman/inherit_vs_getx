import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectionView extends StatelessWidget {
  const SelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () { Get.toNamed('getx_app'); },
              child: const Text('GetX example'),
            ),
            ElevatedButton(
              onPressed: () { Get.toNamed('inherited_widget_app'); },
              child: const Text('Inherited Widget example'),
            ),
            ElevatedButton(
              onPressed: () { Get.toNamed('inherited_model_app'); },
              child: const Text('Inherited Model example'),
            ),
            ElevatedButton(
              onPressed: () { Get.toNamed('inherited_notifier_app'); },
              child: const Text('Inherited Notifier example'),
            ),
          ],
        ),
      ),
    );
  }
}
