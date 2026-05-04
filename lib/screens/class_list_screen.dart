
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/room_provider.dart';

class ClassListScreen extends StatelessWidget {
  const ClassListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Daftar Ruangan',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: 'Kelas'),
              Tab(text: 'Lab'),
              Tab(text: 'Serba Guna'),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: TabBarView(
            children: [
              _buildRoomList(context, roomPrefix: 'R', count: 15),
              _buildRoomList(context, roomPrefix: 'L', count: 15),
              _buildRoomList(context, roomPrefix: 'SG', count: 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomList(BuildContext context, {required String roomPrefix, required int count}) {
    final roomProvider = Provider.of<RoomProvider>(context);

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: count,
      itemBuilder: (context, index) {
        final roomName = '$roomPrefix${index + 1}';
        final bool isAvailable = roomProvider.roomStatus[roomName] ?? true;

        return Card(
          elevation: 4.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: Colors.black.withAlpha(77),
          child: InkWell(
            onTap: () => context.go('/room/$roomName'),
            borderRadius: BorderRadius.circular(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roomName,
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Kapasitas: 30 orang',
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: isAvailable ? Colors.green.shade100 : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: isAvailable ? Colors.green.shade600 : Colors.red.shade600,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      isAvailable ? 'Tersedia' : 'Di-booking',
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: isAvailable ? Colors.green.shade800 : Colors.red.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
