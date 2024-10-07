import 'package:flutter/material.dart';

void main() {
  runApp(AbsensiApp());
}

class AbsensiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi Mahasiswa Untarr',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amberAccent,
        ),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 14.0),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    QRScanPage(),
    StatistikPage(),
    DashboardPage(),
    NotifikasiPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absensi Mahasiswa Untar'),
        elevation: 0,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.indigo,
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.indigo[100],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
        ],
      ),
    );
  }
}

class QRScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.indigo.shade700, Colors.indigo.shade500],
        ),
      ),
      child: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('img/img.png', width: 200, height: 200),
                SizedBox(height: 20),
                Text(
                  'Scan QR Code untuk Absensi',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.qr_code_scanner),
                  label: Text('Mulai Scan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.indigo,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Implementasi scan QR code
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class StatistikPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Statistik Kehadiran Mahasiswa',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.indigo.shade700),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildStatistikCard(context, 'Mata Kuliah A', 0.8),
                _buildStatistikCard(context, 'Mata Kuliah B', 0.75),
                _buildStatistikCard(context, 'Mata Kuliah C', 0.9),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistikCard(BuildContext context, String mataKuliah, double persentase) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KelasListPage(mataKuliah: mataKuliah)),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mataKuliah, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: persentase,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
              ),
              SizedBox(height: 8),
              Text('${(persentase * 100).toStringAsFixed(0)}% Kehadiran'),
            ],
          ),
        ),
      ),
    );
  }
}

class KelasListPage extends StatelessWidget {
  final String mataKuliah;

  KelasListPage({required this.mataKuliah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$mataKuliah - Daftar Kelas'),
      ),
      body: ListView(
        children: [
          _buildKelasTile(context, 'Kelas A'),
          _buildKelasTile(context, 'Kelas B'),
          _buildKelasTile(context, 'Kelas C'),
        ],
      ),
    );
  }

  Widget _buildKelasTile(BuildContext context, String kelas) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MahasiswaListPage(mataKuliah: mataKuliah, kelas: kelas)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kelas,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.indigo),
            ],
          ),
        ),
      ),
    );
  }
}

class MahasiswaListPage extends StatelessWidget {
  final String mataKuliah;
  final String kelas;

  MahasiswaListPage({required this.mataKuliah, required this.kelas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$mataKuliah - Kelas $kelas'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          int nomorInduk = 825220001 + index;
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text('Mahasiswa ${index + 1}'),
              subtitle: Text('NIM: $nomorInduk'),
              trailing: Text('Waktu Masuk: ${_generateRandomTime()}'),
            ),
          );
        },
      ),
    );
  }

  String _generateRandomTime() {
    final hour = (8 + (DateTime.now().millisecondsSinceEpoch % 3)).toString().padLeft(2, '0');
    final minute = (DateTime.now().millisecondsSinceEpoch % 60).toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Dashboard Dosen',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.indigo.shade700),
          ),
          SizedBox(height: 20),
          _buildDashboardCard(
            context,
            'Kehadiran Hari Ini',
            '45',
            Icons.today,
            Colors.green,
          ),
          SizedBox(height: 16),
          _buildDashboardCard(
            context,
            'Kehadiran Minggu Ini',
            '200',
            Icons.date_range,
            Colors.blue,
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Implementasi untuk melihat detail
              },
              child: Text('Lihat Detail'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                foregroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, String count, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 40, color: color),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Jumlah: $count', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.indigo),
          ],
        ),
      ),
    );
  }
}

class NotifikasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Notifikasi Ketidakhadiran',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.indigo.shade700),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildNotifikasiCard(
                  context,
                  'John Doe tidak hadir pada Mata Kuliah A',
                  '2 jam yang lalu',
                  Icons.person_off,
                  Colors.orange,
                ),
                _buildNotifikasiCard(
                  context,
                  'Jane Smith tidak hadir pada Mata Kuliah B',
                  '5 jam yang lalu',
                  Icons.person_off,
                  Colors.orange,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showSendNotificationDialog(context);
            },
            child: Text('Kirim Notifikasi Baru'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotifikasiCard(BuildContext context, String title, String time, IconData icon, Color color) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(time),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status: Belum dibaca', style: TextStyle(color: Colors.red)),
                TextButton(
                  onPressed: () {
                    // Implementasi untuk mengirim ulang notifikasi
                  },
                  child: Text('Kirim Ulang'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSendNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kirim Notifikasi Ketidakhadiran'),
          content: SingleChildScrollView( // Tambahkan ini
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nama Mahasiswa',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Mata Kuliah',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Kirim'),
              onPressed: () {
                // Implementasi pengiriman notifikasi
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Notifikasi berhasil dikirim')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
