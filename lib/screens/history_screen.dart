
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/room_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);
    final bookings = roomProvider.bookings;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Booking',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: bookings.isEmpty
            ? Center(
                child: Text(
                  'Belum ada riwayat booking.',
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.black.withAlpha(77),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        'Ruangan: ${booking.roomId}',
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8.0),
                          Text(
                            'Peminjam: ${booking.studentName}',
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Sesi: ${booking.session}',
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Waktu Booking: ${DateFormat('dd-MM-yyyy HH:mm').format(booking.bookingTime)}',
                            style: GoogleFonts.poppins(
                              fontSize: 12.0,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
