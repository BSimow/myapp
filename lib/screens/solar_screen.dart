import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/isolarapiservice.dart';
import 'package:myapp/widgets/bottom_nav_bar.dart';

class SolarChartPage extends StatefulWidget {
  const SolarChartPage({super.key});

  @override
  State<SolarChartPage> createState() => _SolarChartPageState();
}

class _SolarChartPageState extends State<SolarChartPage> {
  final _api = ISolarApiService(
    appKey: '1216AD583A0BDE926E0F2BF0DACD4D20',
    userAccount: 'walaawwafaa@gmail.com',
    userPassword: 'walaawwafaa@321',
    accessKey: '6ik9jm7xfice4wd38gzizdp7bcm4b0m7',
  );

  DateTime? _startDate;
  DateTime? _endDate;
  bool _loading = false;
  String _selectedType = 'day';

  final List<String> _dataTypes = ['day', 'month', 'year'];
  List<double> dataPoints = [];
  List<String> labels = [];

  Future<void> _pickDate(bool isStart) async {
    final initialDate =
        isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now());
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    if (newDate != null) {
      setState(() {
        if (isStart) {
          _startDate = newDate;
        } else {
          _endDate = newDate;
        }
      });
    }
  }

  Future<void> _fetchChartData() async {
    if (_startDate == null || _endDate == null) return;
    setState(() => _loading = true);

    try {
      final data = await _api.fetchData(
        dataPoint: 'p24',
        dataType: _selectedType,
        start: _startDate!,
        end: _endDate!,
      );

      final raw = data['result_data'].values.first['p24'];
      final values = <double>[];
      final xLabels = <String>[];

      for (var point in raw) {
        values.add(double.tryParse(point['2'].toString()) ?? 0.0);
        xLabels.add(point['time_stamp']);
      }

      setState(() {
        dataPoints = values;
        labels =
            xLabels.map((ts) {
              if (_selectedType == 'year') {
                return ts.substring(0, 4);
              } else if (_selectedType == 'month') {
                return '${ts.substring(0, 4)}-${ts.substring(4, 6)}';
              } else {
                final dt = DateFormat('yyyyMMdd').parse(ts);
                return DateFormat('MM/dd').format(dt);
              }
            }).toList();
      });
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  List<FlSpot> _getSpots() {
    return List.generate(
      dataPoints.length,
      (i) => FlSpot(i.toDouble(), dataPoints[i]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solar Energy Chart')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickDate(true),
                    child: Text(
                      _startDate == null
                          ? 'Start Date'
                          : DateFormat('yyyy-MM-dd').format(_startDate!),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickDate(false),
                    child: Text(
                      _endDate == null
                          ? 'End Date'
                          : DateFormat('yyyy-MM-dd').format(_endDate!),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue!;
                });
              },
              items:
                  _dataTypes.map<DropdownMenuItem<String>>((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type.toUpperCase(),
                        style: const TextStyle(color: Colors.green),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchChartData,
              child: const Text('Get Data'),
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : dataPoints.isEmpty
                ? const Text('No data to display.')
                : Expanded(
                  child: LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          axisNameSize: 16,
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 42,
                            interval:
                                1, // or use a dynamic interval for big datasets
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index >= 0 &&
                                  index < labels.length &&
                                  index % 3 == 0) {
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  space: 8,
                                  child: Transform.rotate(
                                    angle:
                                        -0.5, // Rotate for better readability
                                    child: Text(
                                      labels[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 500,
                            getTitlesWidget:
                                (value, meta) => SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine:
                            (value) =>
                                FlLine(color: Colors.white24, strokeWidth: 1),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          bottom: BorderSide(color: Colors.white, width: 2),
                          left: BorderSide(color: Colors.white),
                          right: BorderSide(color: Colors.transparent),
                          top: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _getSpots(),
                          isCurved: true,
                          color: Colors.white,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentPath: '/solar-data'),
    );
  }
}
