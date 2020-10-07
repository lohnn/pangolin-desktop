/*
Copyright 2019 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(new Clock());
}

class Clock extends StatelessWidget {
  /* final Widget Function() customBar = ({ //customBar in lib/window/window.dart
  /// The function called to close the window.
  Function close,
  /// The function called to minimize the window.
  Function minimize,
  /// The function called to maximize or restore the window.
  Function maximize,
  /// The getter to determine whether or not the window is maximized.
  bool Function() maximizeState}) {
    return ClockBar(close: close, minimize: minimize, maximize: maximize);
  };
  final Color customBackground = const Color(0xFFfafafa);*/

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Clock',
      theme: new ThemeData(
        platform: TargetPlatform.fuchsia,
        primaryColor: Colors.blue[900],
        brightness: Brightness.dark
      ),
      initialRoute: '/world',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/world': (context) => WorldClockTab(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/alarm': (context) => AlarmsTab(),
      },
    );
  }
}

class ClockApp extends StatefulWidget {
  @override
  _ClockApp createState() => _ClockApp();
}

class _ClockApp extends State<ClockApp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tcon = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TabBar(
          controller: tcon,
          tabs: [
            Tab(
              icon: Icon(Icons.access_time),
              text: "Clock"
            ),
            Tab(
              icon: Icon(Icons.alarm),
              text: "Alarm",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tcon,
        children: [
          WorldClockTab(),
          AlarmsTab()
        ],
      )
    );
  }
}

class WorldClockTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dt = DateTime.now();
    return Material(
      child: Center(
        child: Text(
          "${dt.hour}:${dt.minute < 10 ? "0"+dt.minute.toString() : dt.minute}",
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold
          ),
        )
      ),
    );
  }
}

class AlarmsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
