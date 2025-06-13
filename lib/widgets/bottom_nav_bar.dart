import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final String currentPath;

  const BottomNavBar({super.key, required this.currentPath});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final iconSize = isSmallScreen ? 20.0 : 24.0;
    final fontSize = isSmallScreen ? 10.0 : 12.0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavBarItem(
            icon: Icons.home,
            label: 'Home',
            isSelected: currentPath == '/home',
            onTap: () => context.go('/home'),
            iconSize: iconSize,
            fontSize: fontSize,
          ),
          _NavBarItem(
            icon: Icons.solar_power,
            label: 'Live Panels',
            isSelected: currentPath == '/solar-data',
            onTap: () => context.go('/solar-data'),
            iconSize: iconSize,
            fontSize: fontSize,
          ),
          _NavBarItem(
            icon: Icons.cleaning_services,
            label: 'Calender',
            isSelected: currentPath == '/calender',
            onTap: () => context.go('/calender'),
            iconSize: iconSize,
            fontSize: fontSize,
          ),
          _NavBarItem(
            icon: Icons.photo_library,
            label: 'Recent Photo',
            isSelected: currentPath == '/photo',
            onTap: () => context.go('/photo'),
            iconSize: iconSize,
            fontSize: fontSize,
          ),
          _NavBarItem(
            icon: Icons.eco,
            label: 'Efficiency',
            isSelected: currentPath == '/efficiency',
            onTap: () => context.go('/efficiency'),
            iconSize: iconSize,
            fontSize: fontSize,
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double iconSize;
  final double fontSize;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.iconSize,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: isSelected ? const Color(0xFF4CAF50) : Colors.white54,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: isSelected ? const Color(0xFF4CAF50) : Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
