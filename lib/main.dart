import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SwitchExample());
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text('Mon deuxième truc Flutter'),
        ),
        backgroundColor: isOn ? Colors.green : Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isOn ? 'ALLUMÉ 🔥' : 'ÉTEINT ❄️',
              style: TextStyle(
                fontSize: 24,
                color: isOn ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            Switch(
              value: isOn,
              onChanged: (value) {
                setState(() {
                  isOn = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
