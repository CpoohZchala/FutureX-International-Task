import 'package:flutter/material.dart';
import 'package:mytask/utils/local_storage.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int userId;
  final Map<String, dynamic>? userData;

  const DashboardScreen({
    super.key, 
    required this.userId,
    this.userData
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // If userData was passed directly, use it
    if (widget.userData != null) {
      setState(() {
        _userData = widget.userData;
        _isLoading = false;
      });
      return;
    }
    
    // Otherwise, check local storage for user data
    final localUserData = await Storage.getUserData();
    if (localUserData != null && localUserData['userid'] == widget.userId) {
      setState(() {
        _userData = localUserData;
        _isLoading = false;
      });
      return;
    }
    
    try {
    
      await Future.delayed(const Duration(seconds: 1));
      
     
      setState(() {
        _userData = {
          'userid': widget.userId,
          'username': 'User ${widget.userId}',
          'email': 'user${widget.userId}@example.com',
          'phone': '077${widget.userId.toString().padLeft(7, '0')}'
        };
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load user data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _logout() async {
    await Storage.clearUserId();
    await Storage.clearUserData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    await _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard',style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),),
        backgroundColor: const Color.fromARGB(255, 3, 23, 40),
        foregroundColor: Colors.amber,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    const Text(
                      'Failed to load user data',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'User ID: ${widget.userId}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _refreshData,
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: _refreshData,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back, ${_userData!['username']}!',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 2, 12, 21),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'You have successfully logged into your FutureX International account.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // User Profile Section
                      const Text(
                        'User Profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // User Info Card
                      
                        Card(
                          elevation: 4,
                          color: const Color.fromARGB(255, 3, 23, 40), // Light blue background
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                _buildInfoRow(
                                  icon: Icons.person,
                                  label: 'User ID',
                                  value: _userData!['userid'].toString(),
                                ),
                                const Divider(),
                                _buildInfoRow(
                                  icon: Icons.badge,
                                  label: 'Username',
                                  value: _userData!['username'],
                                ),
                                const Divider(),
                                _buildInfoRow(
                                  icon: Icons.email,
                                  label: 'Email',
                                  value: _userData!['email'],
                                ),
                                const Divider(),
                                _buildInfoRow(
                                  icon: Icons.phone,
                                  label: 'Phone',
                                  value: _userData!['phone'],
                                ),
                              ],
                            ),
                          ),
                        ),
                      
                      
                      // Debug Section
                      Card(
                        color: Colors.grey.shade400,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Debug Information',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                        Text('User ID: ${widget.userId}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () async {
                                  await Storage.printUserId();
                                },
                                style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color.fromARGB(255, 2, 11, 18),
                                          ),
                                child: const Text('Print User ID to Console'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Footer
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'FutureX International - Connecting the world through technology',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,color:Colors.amber, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color:Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 119, 157, 180),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}