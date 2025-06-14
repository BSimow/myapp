import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    radius: screenWidth * 0.06,
                    child: Icon(Icons.person_outline,
                        color: Colors.white, size: screenWidth * 0.06),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      Text(
                        'admin',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: const Color(0xFF4CAF50),
                      size: screenWidth * 0.06,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.5,
                      height: screenWidth * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF4CAF50),
                          width: screenWidth * 0.05,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '85%',
                          style: TextStyle(
                            fontSize: screenWidth * 0.12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                        Text(
                          'Energy Usage',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: screenWidth < 600 ? 2 : 4,
                mainAxisSpacing: screenWidth * 0.04,
                crossAxisSpacing: screenWidth * 0.04,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1,
                children: [
                  _MenuCard(
                    icon: Icons.solar_power,
                    title: 'Solar Panels Data',
                    onTap: () => context.go('/solar-data'),
                  ),
                  _MenuCard(
                    icon: Icons.eco,
                    title: 'Efficiency',
                    onTap: () => context.go('/efficiency'),
                  ),
                  _MenuCard(
                    icon: Icons.cleaning_services,
                    title: 'Cleaning',
                    onTap: () => context.go('/cleaning'),
                  ),
                  _MenuCard(
                    icon: Icons.photo_library,
                    title: 'Recent Photo',
                    onTap: () => context.go('/photo'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentPath: '/home'),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: screenWidth * 0.08,
              color: const Color(0xFF4CAF50),
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
