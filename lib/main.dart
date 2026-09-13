import 'package:flutter/material.dart';

void main() {
  runApp(const HatrikAcademyApp());
}

class HatrikAcademyApp extends StatelessWidget {
  const HatrikAcademyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أكاديمية هاتريك',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6B1D2F),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6B1D2F),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardTab(),
    AttendanceTab(),
    PlayerProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('أكاديمية هاتريك (HATRIK)', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF6B1D2F),
          unselectedItemColor: Colors.grey,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'التحضير'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف الفني'),
          ],
        ),
      ),
    );
  }
}

class DashboardTab extends StatelessWidget {
  const DashboardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('إحصائيات الأكاديمية الحية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF6B1D2F))),
        const SizedBox(height: 12),
        Row(
          children: const [
            Expanded(child: KpiCard(title: 'إجمالي اللاعبين', value: '320', color: Color(0xFF6B1D2F))),
            SizedBox(width: 10),
            Expanded(child: KpiCard(title: 'نسبة الحضور', value: '94%', color: Colors.green)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            Expanded(child: KpiCard(title: 'الاشتراكات المحصلة', value: '\$12,400', color: Colors.blueGrey)),
            SizedBox(width: 10),
            Expanded(child: KpiCard(title: 'متأخرات الاشتراك', value: '15', color: Colors.redAccent)),
          ],
        ),
        const SizedBox(height: 24),
        const Text('نجم الشهر والتميز', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF6B1D2F))),
        const SizedBox(height: 12),
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: const ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFF6B1D2F),
              child: Icon(Icons.star, color: Colors.amber),
            ),
            title: Text('اللاعب المثالي: مراد الصبري', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('الفئة السنية: U-14 | نسبة الالتزام: 100%'),
          ),
        ),
      ],
    );
  }
}

class AttendanceTab extends StatefulWidget {
  const AttendanceTab({Key? key}) : super(key: key);

  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab> {
  final List<Map<String, dynamic>> _players = [
    {'name': 'أحمد محمد', 'status': true},
    {'name': 'كريم علي', 'status': true},
    {'name': 'عمر خالد', 'status': false},
    {'name': 'سامي حسن', 'status': true},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _players.length,
      itemBuilder: (context, index) {
        final player = _players[index];
        return Card(
          child: ListTile(
            title: Text(player['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: IconButton(
              icon: Icon(
                player['status'] ? Icons.check_circle : Icons.cancel,
                color: player['status'] ? Colors.green : Colors.red,
                size: 28,
              ),
              onPressed: () {
                setState(() {
                  _players[index]['status'] = !_players[index]['status'];
                });
              },
            ),
          ),
        );
      },
    );
  }
}

class PlayerProfileTab extends StatelessWidget {
  const PlayerProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF6B1D2F),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          const Text('بطاقة الأداء الفني والبدني', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  SkillProgressRow(label: 'التمرير', score: 0.85),
                  SkillProgressRow(label: 'التسديد', score: 0.70),
                  SkillProgressRow(label: 'اللياقة البدنية', score: 0.90),
                  SkillProgressRow(label: 'الانضباط التكتيكي', score: 0.95),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const KpiCard({Key? key, required this.title, required this.value, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(top: BorderSide(color: color, width: 4)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

class SkillProgressRow extends StatelessWidget {
  final String label;
  final double score;

  const SkillProgressRow({Key? key, required this.label, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
            child: LinearProgressIndicator(
              value: score,
              color: const Color(0xFF6B1D2F),
              backgroundColor: Colors.grey[200],
              minHeight: 10,
            ),
          ),
          const SizedBox(width: 10),
          Text('${(score * 10).toInt()}/10'),
        ],
      ),
    );
  }
}
