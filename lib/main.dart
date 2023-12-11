import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: MainWindow(),
        ),
      ),
    );
  }
}

class MainWindow extends StatefulWidget {
  const MainWindow({Key? key}) : super(key: key);

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  int _breakeSeconds = 60;
  int _rounds = 3;
  int _minutes = 1;
  int _seconds = 60;
  bool _isPaused = true;
  late final Timer _timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          Text('$_breakeSeconds seconds break'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _removeBreakSeconds();
                  });
                },
                child: Text('-'),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _addBreakSeconds();
                  });
                },
                child: Text('+'),
              ),
            ],
          ),
          Text('$_rounds rounds '),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _removeRound();
                  });
                },
                child: Text('-'),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _addRound();
                  });
                },
                child: Text('+'),
              ),
            ],
          ),
          Text('round $_minutes minutes '),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _removeMinute();
                  });
                },
                child: Text('-'),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _addMinute();
                  });
                },
                child: Text('+'),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  togglePause();
                  print('tap');
                },
                child: PlayButton(_isPaused),
              ),
            ],
          ),
          Text(_seconds.toString()),
        ],
      ),
    );

  }

  void _startTimer() {
    _timer = Timer.periodic(
        const Duration(seconds: 1), (timer) {
          print('_startTimer()');
          _decrement();
        });
  }

  void togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _decrement() {
    print('decrement');
    if (!_isPaused && _seconds > 0) {
      setState(() {
        _seconds--;
      });
    }

  }

  void _addMinute() {
    setState(() {
      _minutes++;
    });
  }
  void _removeMinute() {
    if (_minutes > 0) {
      setState(() {
        _minutes--;
      });
    }
  }

  void _removeRound() {
    if (_rounds > 0) {
      setState(() {
        _rounds--;
      });
    }
  }

  void _addRound() {
    setState(() {
      _rounds++;
    });
  }

  void _removeBreakSeconds() {
    if (_breakeSeconds > 30) {
      setState(() {
        _breakeSeconds -= 30;
      });
    }
  }

  void _addBreakSeconds() {
    setState(() {
      _breakeSeconds += 30;
    });
  }
}

class PlayButton extends StatelessWidget {
  PlayButton(final bool isPaused, {Key? key}) : _isPaused = isPaused, super(key: key);

  final bool _isPaused;
  Color _color = Colors.greenAccent;
  String _text = 'Start';
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: _getColor(),
      child: Text(_getText()),
    );
  }

  _getColor() {
    if (_isPaused) {
      return Colors.greenAccent;
    }
    return Colors.green;
  }

  String _getText() {
    if (_isPaused) {
      return 'Start';
    }
    return 'Stop';
  }
}

