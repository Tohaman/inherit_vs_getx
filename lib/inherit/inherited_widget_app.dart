import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InheritedWidgetApp extends StatelessWidget {
  const InheritedWidgetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("-build InheritedWidgetApp");
    return const Scaffold(
      body: SafeArea(
        child: DataOwnerStateful(),
      ),
    );
  }
}

class DataOwnerStateful extends StatefulWidget {
  const DataOwnerStateful({Key? key}) : super(key: key);

  @override
  _DataOwnerStatefulState createState() => _DataOwnerStatefulState();
}

class _DataOwnerStatefulState extends State<DataOwnerStateful> {
  var _valueOne = 0;
  var _valueTwo = 0;

  void _incrementOne() {
    _valueOne++;
    setState(() {});
  }

  void _incrementTwo() {
    _valueTwo++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("----");
    print("build DataOwnerStateful");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _incrementOne,
          child: const Text('Жми раз'),
        ),
        ElevatedButton(
          onPressed: _incrementTwo,
          child: const Text('Жми два'),
        ),
        DataProviderInherited(
          valueOne: _valueOne,
          valueTwo: _valueTwo,
          child: const DataConsumerStateless()
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: const Text('DEMO InheritedWidget - при изменении любого значения в инхерите, обновляются ВСЕ подписанные на него виджеты')
        )
      ],
    );
  }
}


class DataConsumerStateless extends StatelessWidget {
  const DataConsumerStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build DataConsumerStateless");
    /// Получаем значение из инхерита и подписываемся на изменения
    final value = context.dependOnInheritedWidgetOfExactType<DataProviderInherited>()?.valueOne ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$value'),
        const DataConsumerStateful(),
      ],
    );
  }
}
class DataConsumerStateful extends StatefulWidget {
  const DataConsumerStateful({Key? key}) : super(key: key);

  @override
  _DataConsumerStatefulState createState() => _DataConsumerStatefulState();
}

class _DataConsumerStatefulState extends State<DataConsumerStateful> {
  @override
  Widget build(BuildContext context) {
    print("build DataConsumerStateful");
    /// Получаем значение из инхерита, но не подписываемся на изменения
    // final element = context.getElementForInheritedWidgetOfExactType<DataProviderInherited>();
    // final dataProvider = element?.widget as DataProviderInherited;
    // final value = dataProvider.value;
    // /// А так подписываемся на изменения элемента
    // if (element != null) {
    //   context.dependOnInheritedElement(element);
    // }

    /// Получаем значение из инхерита и подписываемся на изменения
    final value = DataProviderInherited.of(context)?.valueTwo ?? 0;
    return Text('$value');
  }
}


class DataProviderInherited extends InheritedWidget {
  final int valueOne;
  final int valueTwo;

  const DataProviderInherited({
    Key? key,
    required this.valueOne,
    required this.valueTwo,
    required Widget child,
  }) : super(key: key, child: child);

  static DataProviderInherited? of(BuildContext context) {
    final DataProviderInherited? result = context.dependOnInheritedWidgetOfExactType<DataProviderInherited>();
    return result;
  }

  @override
  bool updateShouldNotify(DataProviderInherited oldWidget) {
    return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo;
  }
}