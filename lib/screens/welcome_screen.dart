import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // ✅ Background Image
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black54,
                  BlendMode.darken,
                ),
              ),
            ),
          ),

          // ✅ Faded full-width "Solar Monitor"
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Solar\nMonitor',
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.w900,
                    color: Colors.white.withOpacity(0.04),
                    height: 1.1,
                  ),
                  maxLines: 2,
                  softWrap: true,
                ),
              ),
            ),
          ),

          // ✅ Foreground content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),

                  // ✅ Headline with icon
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Solar ',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFCCFFB0),
                          ),
                        ),
                        TextSpan(
                          text: 'panels\nreduce climate\nchange ',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Icon(Icons.bolt, color: Colors.green, size: 28),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Solar panel monitoring systems gather data from various sensors and meters installed within the solar PV system.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Center(
                    child: SizedBox(
                      width: screenWidth > 335 ? 335 : screenWidth * 0.85,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () => context.go('/signin'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAEE0A3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
