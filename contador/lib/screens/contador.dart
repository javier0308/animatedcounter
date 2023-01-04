import 'package:contador/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  // int _counter = Preferences.counter;
  int? _oldcounter;

  void increment() {
    Preferences.counter++;
    setState(() {});
  }

  void decrecer() {
    if (Preferences.counter > 0) {
      Preferences.counter--;
    }
    setState(() {});
  }

  void reset() {
    Preferences.counter = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador animado'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Numero de clicks',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              key: Key(Preferences.counter.toString()),
              duration: const Duration(milliseconds: 700),
              builder: (context, value, _) {
                return Stack(
                  children: [
                    if (_oldcounter != null)
                      //Texto de old value
                      Opacity(
                        opacity: 1 - value,
                        child: Transform.translate(
                          offset: Offset(50 * value, 0.0),
                          child: Text(
                            _oldcounter.toString(),
                            style: const TextStyle(fontSize: 80),
                          ),
                        ),
                      ),
                    Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(-50 * (1 - value), 0.0),
                        child: Text(
                          Preferences.counter.toString(),
                          style: const TextStyle(fontSize: 80),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFloatingButton(
        decrement: decrecer,
        increment: increment,
        reset: reset,
      ),
    );
  }
}

class CustomFloatingButton extends StatelessWidget {
  final Function increment, decrement, reset;
  const CustomFloatingButton({
    Key? key,
    required this.increment,
    required this.decrement,
    required this.reset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            child: const Icon(
              Icons.exposure_plus_1_outlined,
            ),
            onPressed: () => increment()),
        FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: const Icon(
            Icons.restart_alt,
          ),
          onPressed: () => reset(),
        ),
        FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: const Icon(
            Icons.exposure_minus_1_outlined,
          ),
          onPressed: () => decrement(),
        ),
      ],
    );
  }
}
