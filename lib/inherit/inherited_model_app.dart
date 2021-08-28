import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InheritedModelApp extends StatelessWidget {
  const InheritedModelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("-build InheritedModelApp");
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
            child: const Text('DEMO InheritedModel - все то же, что и InheritedWidget, '
                'но есть возможность отделять подписчиков по аспектам. Но как и InheritedWidget '
                'позволяет передавать значения только вниз по дереву'),
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
    final value = context
        .dependOnInheritedWidgetOfExactType<DataProviderInherited>(aspect: 'one')
        ?.valueOne
        ?? 0;
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
    /// Получаем значение из инхерита и подписываемся на изменения
    final value = context
        .dependOnInheritedWidgetOfExactType<DataProviderInherited>(aspect: 'two')
        ?.valueTwo
        ?? 0;
    return Text('$value');
  }
}

// https://youtu.be/n_HLJUBkc48?t=2472
// Переделываем InheritedWidget в InheritedModel
class DataProviderInherited extends InheritedModel<String> {
  final int valueOne;
  final int valueTwo;

  const DataProviderInherited({
    Key? key,
    required this.valueOne,
    required this.valueTwo,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(DataProviderInherited oldWidget) {
    return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo;
  }

  @override
  //dependencies - это и есть aspectы, указанные при вызове dependOnInheritedWidgetOfExactType
  bool updateShouldNotifyDependent(covariant DataProviderInherited oldWidget, Set<String> dependencies) {
    final isValueOneUpdated =
        valueOne != oldWidget.valueOne && dependencies.contains('one');
    final isValueTwoUpdated =
        valueTwo != oldWidget.valueTwo && dependencies.contains('two');
    return isValueOneUpdated || isValueTwoUpdated;
  }
}