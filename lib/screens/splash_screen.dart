import 'package:flutter/material.dart';
import 'package:mytask/utils/local_storage.dart';
import '../services/api_service.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), _checkStatus);
  }

  Future<void> _checkStatus() async {
    try {
      // Clean up any old keys first to avoid conflicts
      await Storage.cleanupOldKeys();

      // Debug: Print all stored data
      await Storage.printAllStoredData();

      // Get stored user ID using the correct key ('user_id')
      final int? storedUserId = await Storage.getUserId();

      // If no user ID is stored, navigate to login screen
      if (storedUserId == null) {
        print('🔄 No stored user ID, navigating to Login');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        return;
      }

      print('🔄 Checking status for user ID: $storedUserId');

      // Check user status with the API
      final response = await ApiService.checkStatus(storedUserId);

      if (response['status'] == 'registered') {
        print('✅ User is registered, navigating to Dashboard');

        // Try to get user data from local storage
        final userData = await Storage.getUserData();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DashboardScreen(userId: storedUserId, userData: userData),
          ),
        );
      } else if (response['status'] == 'unregistered') {
        print('❌ User is not registered, navigating to Login');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        print('⚠️ Unexpected status response: ${response['status']}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      print('❌ Error in splash screen: $e');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 19, 32),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'FutureX International',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
