import 'package:flutter/material.dart';

void main() {
  runApp(const ShapeLabApp());
}

class ShapeLabApp extends StatelessWidget {
  const ShapeLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF141619),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E2126),
          centerTitle: true,
          elevation: 0,
        ),
        sliderTheme: const SliderThemeData(
          activeTrackColor: Colors.redAccent,
          thumbColor: Colors.red,
          inactiveTrackColor: Colors.white24,
        ),
      ),
      home: const RedBoxConfigurator(),
    );
  }
}

class RedBoxConfigurator extends StatefulWidget {
  const RedBoxConfigurator({super.key});

  @override
  State<RedBoxConfigurator> createState() => _RedBoxConfiguratorState();
}

class _RedBoxConfiguratorState extends State<RedBoxConfigurator> {
  double _boxWidth = 110.0;
  double _boxHeight = 110.0;
  double _topRightRadius = 40.0;

  void _resetDefaults() {
    setState(() {
      _boxWidth = 110.0;
      _boxHeight = 110.0;
      _topRightRadius = 40.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Конфігуратор контейнера'),
        actions: [
          IconButton(
            onPressed: _resetDefaults,
            tooltip: 'Скинути параметри',
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2126),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  _controlRow(
                    title: 'Ширина',
                    currentValue: _boxWidth,
                    min: 20,
                    max: 240,
                    onChanged: (v) => setState(() => _boxWidth = v),
                  ),
                  const SizedBox(height: 8),
                  _controlRow(
                    title: 'Висота',
                    currentValue: _boxHeight,
                    min: 20,
                    max: 240,
                    onChanged: (v) => setState(() => _boxHeight = v),
                  ),
                  const SizedBox(height: 8),
                  _controlRow(
                    title: 'Радіус верхнього правого кута',
                    currentValue: _topRightRadius,
                    min: 0,
                    max: 150,
                    onChanged: (v) => setState(() => _topRightRadius = v),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: Container(
                  width: _boxWidth,
                  height: _boxHeight,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(_topRightRadius),
                    ),
                  ),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2126),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_boxWidth.toInt()} × ${_boxHeight.toInt()} px  |  R: ${_topRightRadius.toInt()}',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _controlRow({
    required String title,
    required double currentValue,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: Colors.white70)),
            Text(
              '${currentValue.toStringAsFixed(1)} px',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
        Slider(
          value: currentValue,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }
}