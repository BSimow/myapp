import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/isolarapiservice.dart';
import 'package:myapp/widgets/bottom_nav_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

class EfficiencyScreen extends StatefulWidget {
  const EfficiencyScreen({super.key});

  @override
  State<EfficiencyScreen> createState() => _EfficiencyScreenState();
}

class _EfficiencyScreenState extends State<EfficiencyScreen> {
  double _efficiency = 0.0;
  double _totalEnergy = 0.0;
  bool _loading = true;

  final _api = ISolarApiService(
    appKey: '1216AD583A0BDE926E0F2BF0DACD4D20',
    userAccount: 'walaawwafaa@gmail.com',
    userPassword: 'walaawwafaa@321',
    accessKey: '6ik9jm7xfice4wd38gzizdp7bcm4b0m7',
  );

  DateTime _start = DateTime(DateTime.now().year, DateTime.now().month - 1, 1);
  DateTime _end = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchEfficiency();
  }

  Future<void> _fetchEfficiency() async {
    try {
      final data = await _api.fetchData(
        dataPoint: 'p24',
        dataType: 'month',
        start: _start,
        end: _end,
      );

      final entries = data['result_data'].values.first['p24'];
      final total = entries
          .map((item) => double.tryParse(item['2'].toString()) ?? 0.0)
          .reduce((a, b) => a + b);

      // Example logic: efficiency is percent of 12,000 kWh capacity
      final capacity = 12000.0;
      final percent = (total / capacity).clamp(0.0, 1.0);

      setState(() {
        _totalEnergy = total;
        _efficiency = percent;
        _loading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            _loading
                ? const Center(
                  child: CircularProgressIndicator(color: Colors.greenAccent),
                )
                : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.arrow_back_ios, color: Colors.white),
                              Icon(Icons.more_vert, color: Colors.white),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Text(
                            "System Efficiency",
                            style: GoogleFonts.orbitron(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          CircularPercentIndicator(
                            radius: 120.0,
                            lineWidth: 18.0,
                            animation: true,
                            percent: _efficiency,
                            circularStrokeCap: CircularStrokeCap.round,
                            backgroundColor: Colors.green.shade800.withOpacity(
                              0.3,
                            ),
                            progressColor: Colors.greenAccent,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${(_efficiency * 100).toStringAsFixed(1)}%",
                                  style: GoogleFonts.orbitron(
                                    textStyle: const TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Icon(
                                  Icons.flash_on,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          Text(
                            "Data Type: Daily\nRange: ${DateFormat('MMM–yyyy').format(_start)} to ${DateFormat('MMM–yyyy').format(_end)}\nTotal Energy Generated: ${_totalEnergy.toStringAsFixed(0)} kWh",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.orbitron(
                              textStyle: const TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
      bottomNavigationBar: const BottomNavBar(currentPath: '/efficiency'),
    );
  }
}
