import 'package:flutter/material.dart';

class InheritedNotifierApp extends StatelessWidget {
  const InheritedNotifierApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SimpleCalcWidget(),
      ),
    );
  }
}

class SimpleCalcWidget extends StatelessWidget {
  const SimpleCalcWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FirstNumberWidget(),
            const SizedBox(height: 15,),
            const SecondNumberWidget(),
            const SizedBox(height: 15,),
            const SumButtonWidget(),
            const SizedBox(height: 15,),
            const ResultWidget(),
          ],
        ),
      ),
    );
  }
}

class FirstNumberWidget extends StatelessWidget {
  const FirstNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build FirstNumberWidget');
    return const TextField(
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }
}

class SecondNumberWidget extends StatelessWidget {
  const SecondNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build SecondNumberWidget');
    return const TextField(
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }
}

class SumButtonWidget extends StatelessWidget {
  const SumButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){},
        child: const Text('Посчитать сумму'),
    );
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Результат');
  }
}
