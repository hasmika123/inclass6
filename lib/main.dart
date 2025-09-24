import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;
  static const int maxLaunchValue = 100;

  void _increment() {
    setState(() {
      if (_counter < maxLaunchValue) {
        _counter++;
        if (_counter == maxLaunchValue) {
          _showLiftoffDialog();
        }
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  void _emergencyAbort() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red, size: 30),
              SizedBox(width: 10),
              Text(
                'EMERGENCY ABORT',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to abort the mission?\nThis will reset the counter to 0.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _counter = 0;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('🚨 Mission Aborted - Counter Reset to 0'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text(
                'ABORT MISSION',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLiftoffDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding: EdgeInsets.all(16),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.rocket_launch, color: Colors.orange, size: 24),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  'LIFTOFF! 🚀',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.celebration,
                  color: Colors.amber,
                  size: 40,
                ),
                SizedBox(height: 10),
                Text(
                  'Congratulations! 🎉',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Mission Successful!\nYour rocket has launched!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue[700],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.red],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '🌟 LAUNCH COMPLETE 🌟',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Continue Mission',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Color _getTextColor() {
    if (_counter == 0) {
      return Colors.red;
    } else if (_counter == maxLaunchValue) {
      return Colors.white;
    } else if (_counter > 50) {
      return Colors.green;
    } else {
      return Colors.orange;
    }
  }

  String _getDisplayText() {
    if (_counter == maxLaunchValue) {
      return 'LIFTOFF!';
    }
    return '$_counter';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Launch Controller'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _counter == maxLaunchValue ? Colors.red[700] : Colors.blue,
                borderRadius: BorderRadius.circular(15),
                boxShadow: _counter == maxLaunchValue ? [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ] : null,
              ),
              child: Text(
                _getDisplayText(),
                style: TextStyle(
                  fontSize: _counter == maxLaunchValue ? 40.0 : 50.0,
                  color: _getTextColor(),
                  fontWeight: FontWeight.bold,
                  letterSpacing: _counter == maxLaunchValue ? 2.0 : 0,
                ),
              ),
            ),
          ),
          Slider(
            min: 0,
            max: maxLaunchValue.toDouble(),
            value: _counter.toDouble(),
            onChanged: (double value) {
              int newValue = value.toInt();
              setState(() {
                _counter = newValue;
                if (_counter == maxLaunchValue) {
                  Future.delayed(Duration(milliseconds: 100), () {
                    _showLiftoffDialog();
                  });
                }
              });
            },
            activeColor: _counter == maxLaunchValue ? Colors.red : Colors.blue,
            inactiveColor: Colors.red,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _counter >= maxLaunchValue ? null : _increment,
            child: Text(_counter >= maxLaunchValue ? "LAUNCHED!" : "Ignite"),
            style: ElevatedButton.styleFrom(
              backgroundColor: _counter >= maxLaunchValue ? Colors.grey : Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _counter > 0 ? _decrement : null,
                icon: Icon(Icons.remove, color: Colors.white),
                label: Text("Decrement", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _counter > 0 ? Colors.blue : Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _reset,
                icon: Icon(Icons.refresh, color: Colors.white),
                label: Text("Reset", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _emergencyAbort,
                icon: Icon(Icons.warning, color: Colors.white),
                label: Text("ABORT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
