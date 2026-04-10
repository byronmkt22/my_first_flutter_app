import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final int counter;

  const SecondScreen({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You arrived here with a counter value of:'),
            //Text('$counter', style: Theme.of(context).textTheme.headlineMedium),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.indigoAccent,
                fontStyle: FontStyle.italic,
                letterSpacing: 2.0,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
