import 'dart:async';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentTime = 0;
  bool _isRunning = false;
  Timer? _timer;

  void _startTimer() {
    if (_isRunning) return;
    
    setState(() {
      _isRunning = true;
      _currentTime = 100;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _currentTime--;
      });
      
      if (_currentTime <= 0) {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _currentTime = 0;
    });
  }

  void _restartTimer() {
    _stopTimer();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time is: $_currentTime',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRunning ? null : _startTimer,
              child: Text(_isRunning ? 'Running...' : 'Start'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _restartTimer,
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyApp());
  }
}
