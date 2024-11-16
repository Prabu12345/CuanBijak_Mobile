import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class DashboardPage extends StatefulWidget {
  final String text;

  const DashboardPage({super.key, required this.text});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  int _pageIndex = 0;
  String displayText = "";
  final PageController _pageController = PageController();
  final GlobalKey _nvGlobalKey = GlobalKey();

  // Untuk Ganti background navBar (Sementara Tidak Di Gunakan) - Berfungsi
  Color _backgroundColor = Colors.white; // Warna default
  final List<Color> _pageColors = [
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  MotionToast comingSoonToast = MotionToast.info(title: Text('Coming Soon'), description: Text('This feature will be coming soon'),);

  @override
  void initState() {
    super.initState();
    displayText = widget.text; // Initialize state with received text
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageIndex,
        backgroundColor: _backgroundColor,
        color: Colors.blueAccent,
        key: _nvGlobalKey,
        items: const [
          Icon(
            Icons.home_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.edit_document,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.account_circle_outlined,
            size: 30,
            color: Colors.white,
          )
        ],
        onTap: (index) {
          setState(() {
            _pageIndex = index;
            _backgroundColor =
                _pageColors[index]; // Trigger ganti warna background navBar
            _pageController.jumpToPage(index);
          });
        },
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (value) => {_pageIndex = value},
            children: [
              _homePage(),
              _projectPage(),
              _accountPage()
            ],
          ),
        ),
      ),
    );
  }

  Widget _homePage() {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $displayText!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Welcome back',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Statistics Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard('Tasks', '0', Colors.blue),
              _buildStatCard('Document', '0', Colors.purple),
              _buildStatCard('Projects', '0', Colors.orange),
            ],
          ),
          const SizedBox(height: 30),

          // Quick Access Section
          const Text(
            'Quick Access',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAccessButton(Icons.file_copy, 'Document', () {
                comingSoonToast.show(context);
              }),
              _buildAccessButton(Icons.settings, 'Settings', () {
                comingSoonToast.show(context);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _projectPage() {
    // Contoh daftar proyek
    List<String> projects = ["Project Alpha", "Project Beta", "Project Gamma"];

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: ElevatedButton(
              onPressed: () {
                comingSoonToast.show(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Manage Project",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      projects[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        comingSoonToast.show(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "See Task",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _accountPage() {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Image
          const Center(
            child: CircleAvatar(
              radius: 70,
            ),
          ),
          const SizedBox(height: 20),

          // Name
          const Center(
            child: Text(
              'M. Prabu Kiandamar Utoyo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Email
          Center(
            child: Text(
              'prabu.kiandamar@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Info section using widget instead of class
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Phone',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '+62 1234 5678 890',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Address',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '1234 Main Street, City, Country',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Joined',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'November 2024',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Statistic Card Builder
  Widget _buildStatCard(String title, String count, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Quick Access Button Builder
  Widget _buildAccessButton(
      IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
