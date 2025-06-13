import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';

class EfficiencyScreen extends StatelessWidget {
  const EfficiencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Efficiency Data'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a date and time range',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF4CAF50),
                  ),
            ),
            const SizedBox(height: 30),
            const _DateTimeRow(
              label: 'start date:',
              date: 'Jun 10, 2024',
              time: '9:41 AM',
            ),
            const SizedBox(height: 20),
            const _DateTimeRow(
              label: 'end date:',
              date: 'Jun 10, 2024',
              time: '9:41 AM',
            ),
            const SizedBox(height: 20),
            const _DateRow(
              label: 'day:',
              date: 'Jun 10, 2024',
            ),
            const SizedBox(height: 40),
            Text(
              'Pick the data type',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF4CAF50),
                  ),
            ),
            const SizedBox(height: 30),
            _DataTypeButton(title: 'Fetch Yearly Data', onTap: () {}),
            const SizedBox(height: 15),
            _DataTypeButton(title: 'Fetch Daily Data', onTap: () {}),
            const SizedBox(height: 15),
            _DataTypeButton(title: 'Fetch Minute Data', onTap: () {}),
            const SizedBox(height: 15),
            _DataTypeButton(title: 'Fetch Monthly Data', onTap: () {}),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentPath: '/efficiency'),
    );
  }
}

class _DateTimeRow extends StatelessWidget {
  final String label;
  final String date;
  final String time;

  const _DateTimeRow({
    required this.label,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
        ),
        Text(
          date,
          style: const TextStyle(color: Color(0xFF4CAF50)),
        ),
        Text(
          'start hour:',
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
        Text(
          time,
          style: const TextStyle(color: Color(0xFF4CAF50)),
        ),
      ],
    );
  }
}

class _DateRow extends StatelessWidget {
  final String label;
  final String date;

  const _DateRow({
    required this.label,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
        ),
        Text(
          date,
          style: const TextStyle(color: Color(0xFF4CAF50)),
        ),
      ],
    );
  }
}

class _DataTypeButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _DataTypeButton({
    required this.title,
    required this.onTap,
  });

  @override
  State<_DataTypeButton> createState() => _DataTypeButtonState();
}

class _DataTypeButtonState extends State<_DataTypeButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
