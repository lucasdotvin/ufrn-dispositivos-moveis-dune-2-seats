import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  static const int maxSeats = 18;

  int _occupiedSeats = 0;

  String _message = '';

  void _changeOccupiedSeats(int value) {
    setState(() {
      _occupiedSeats += value;
      if (_occupiedSeats < 0) {
        _occupiedSeats = 0;
      } else if (_occupiedSeats > maxSeats) {
        _occupiedSeats = maxSeats;
      }

      _defineMessage();
    });
  }

  void _defineMessage() {
    setState(() {
      if (_occupiedSeats == 0) {
        _message = 'Vamos falir! O cinema está vazio!';
      } else if (_occupiedSeats == maxSeats) {
        _message = 'Casa cheia (é um cinema bem pequeno)!';
      } else {
        _message = 'Ainda temos lugares disponíveis!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 4,
              children: List.generate(maxSeats, (index) {
                if (index < _occupiedSeats) {
                  return const Icon(
                    Icons.check_box,
                    size: 42,
                    color: Colors.green,
                  );
                }

                return const Icon(
                  Icons.add_box_outlined,
                  size: 42,
                  color: Colors.indigo,
                );
              }),
            ),
            const Divider(
              height: 48,
            ),
            Text(
              _message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _changeOccupiedSeats(-1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Cancelar'),
                ),
                const VerticalDivider(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () => _changeOccupiedSeats(1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Reservar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
