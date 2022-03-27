import 'package:flutter/material.dart';
import 'package:mymeteo/providers/counter.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Text(context.watch<Counter>().count.toString()),
        TextButton(
            onPressed: () {
              context.read<Counter>().increment();
            },
            child: const Text('increment'))
      ],
    ));
  }
}
