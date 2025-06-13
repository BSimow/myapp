import 'package:flutter/material.dart';
import 'package:myapp/widgets/bottom_nav_bar.dart';
import 'package:myapp/widgets/calender_ui.dart'; // Keep your custom calendar widget

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final List<DateTime> _selectedDates = [];
  final List<CalenderUi> _calenderWidgets = [];

  @override
  void initState() {
    super.initState();
    _buildCalenderWidgets();
  }

  void _buildCalenderWidgets() {
    _calenderWidgets.clear();
    for (int i = 0; i < 12; i++) {
      _calenderWidgets.add(
        CalenderUi(
          monthIndex: i,
          bookedDates: const [], // Empty since no Firebase
          selectDate: _selectDate,
          getSelectedDate: _getSelectedDates,
        ),
      );
    }
  }

  void _selectDate(DateTime dateTime) {
    setState(() {
      if (_selectedDates.contains(dateTime)) {
        _selectedDates.remove(dateTime);
      } else {
        _selectedDates.add(dateTime);
      }
    });
  }

  List<DateTime> _getSelectedDates() {
    return _selectedDates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Dates'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Sun'),
                Text('Mon'),
                Text('Tue'),
                Text('Wed'),
                Text('Thu'),
                Text('Fri'),
                Text('Sat'),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child:
                  _calenderWidgets.isEmpty
                      ? const Center(child: Text('No calendar available.'))
                      : PageView.builder(
                        itemCount: _calenderWidgets.length,
                        itemBuilder: (context, index) {
                          return _calenderWidgets[index];
                        },
                      ),
            ),
            const SizedBox(height: 20),
            Text(
              'Selected Days: ${_selectedDates.length}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentPath: '/calender'),
    );
  }
}
