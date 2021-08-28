import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetXApp extends StatelessWidget {
  const GetXApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FirstNumberWidget(),
              SizedBox(height: 15,),
              SecondNumberWidget(),
              SizedBox(height: 15,),
              SumButtonWidget(),
              SizedBox(height: 15,),
              ResultWidget(),
            ],
          ),
        ),
      ),
    );
  }
}


class FirstNumberWidget extends GetWidget<SimpleCalcViewModel> {
  const FirstNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build FirstNumberWidget');
    return TextField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      onChanged: (value) => controller.firstNumber = value,
    );
  }
}

class SecondNumberWidget extends GetWidget<SimpleCalcViewModel> {
  const SecondNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build SecondNumberWidget');
    return TextField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      onChanged: (value) => controller.secondNumber = value,
    );
  }
}

class SumButtonWidget extends GetWidget<SimpleCalcViewModel> {
  const SumButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build SumButtonWidget');
    return ElevatedButton(
      onPressed: () {
        print('button pressed');
        controller.sum();
      },
      child: const Text('Посчитать сумму'),
    );
  }
}

class ResultWidget extends GetWidget<SimpleCalcViewModel> {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build ResultWidget');
    return Obx(() => Text('Результат: ${controller.sumResult}'));
  }
}

class SimpleCalcViewModel extends GetxController {
  int? _firstNumber;

  set firstNumber(String value) => _firstNumber = int.tryParse(value);

  int? _secondNumber;

  set secondNumber(String value) => _secondNumber = int.tryParse(value);

  final RxnInt _sumResult = RxnInt();

  int? get sumResult => _sumResult.value;


  @override
  void onInit() {
    print("SimpleCalcViewModel init");
    super.onInit();
  }

  void sum() {
    print('sum вызван');
    int? sumResult;
    if (_firstNumber != null && _secondNumber != null) {
      sumResult = _firstNumber! + _secondNumber!;
    } else {
      sumResult = null;
    }
    if (this.sumResult != sumResult) {
      _sumResult.value = sumResult;
    }
  }
}
