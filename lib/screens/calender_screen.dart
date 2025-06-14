import 'package:flutter/material.dart';
import 'package:myapp/widgets/bottom_nav_bar.dart';
import 'package:myapp/widgets/calender_ui.dart';

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
          bookedDates: const [],
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

  List<DateTime> _getSelectedDates() => _selectedDates;

  void _showGoodJobDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFFFC107),
                  size: 40,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Good Job!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'You’ve successfully marked the cleaning!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Thanks!'),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Cleaning Dates')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Sun',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Mon',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Tue',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Wed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Thu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Fri',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Sat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ✅ Flexible used instead of Expanded
            Flexible(
              child:
                  _calenderWidgets.isEmpty
                      ? const Center(child: Text('No calendar available.'))
                      : PageView.builder(
                        itemCount: _calenderWidgets.length,
                        itemBuilder:
                            (context, index) => _calenderWidgets[index],
                      ),
            ),

            const SizedBox(height: 10),
            Text(
              'Selected Days: ${_selectedDates.length}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showGoodJobDialog,
                icon: const Icon(Icons.cleaning_services),
                label: const Text('Mark as Cleaned'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Extra space from button to bottom nav
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentPath: '/calender'),
    );
  }
}
