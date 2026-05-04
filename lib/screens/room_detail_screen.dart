
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/booking_model.dart';
import 'package:myapp/providers/room_provider.dart';

class RoomDetailScreen extends StatefulWidget {
  final String roomId;

  const RoomDetailScreen({super.key, required this.roomId});

  @override
  RoomDetailScreenState createState() => RoomDetailScreenState();
}

class RoomDetailScreenState extends State<RoomDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _selectedSession;

  final List<String> _sessions = [
    'Sesi 1 (08:00 - 09:30)',
    'Sesi 2 (09:45 - 11:15)',
    'Sesi 3 (11:30 - 13:00)',
    'Sesi 4 (13:30 - 15:00)',
    'Sesi 5 (15:15 - 16:45)',
    'Sesi 6 (17:00 - 18:30)',
    'Sesi 7 (18:45 - 20:15)',
    'Sesi 8 (20:30 - 22:00)',
    'Sesi 9 (22:15 - 23:45)',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String _getRoomType(String roomId) {
    if (roomId.startsWith('R')) return 'Kelas';
    if (roomId.startsWith('L')) return 'Lab';
    if (roomId.startsWith('SG')) return 'Serba Guna';
    return 'Lainnya';
  }

  void _processBooking() {
    if (_formKey.currentState!.validate()) {
      final booking = Booking(
        roomId: widget.roomId,
        studentName: _nameController.text,
        session: _selectedSession!,
        bookingTime: DateTime.now(), // Add booking time
      );
      context.read<RoomProvider>().addBooking(booking);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Booking Berhasil'),
          content: Text(
              'Ruangan ${widget.roomId} telah di-booking oleh ${_nameController.text} untuk sesi $_selectedSession.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                context.go('/'); // Go back to the home screen
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                context.go('/history');
              },
              child: const Text('Lihat Riwayat'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);
    final bool isAvailable = roomProvider.roomStatus[widget.roomId] ?? true;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Ruangan',
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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Text(
                widget.roomId,
                style: GoogleFonts.poppins(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24.0),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Nama Mahasiswa/Peminjam'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: '${_getRoomType(widget.roomId)} - ${widget.roomId}',
                readOnly: true,
                style: const TextStyle(color: Colors.white70),
                decoration: _inputDecoration('Ruangan'),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: _inputDecoration('Pilih Sesi'),
                dropdownColor: Colors.blue.shade900,
                style: const TextStyle(color: Colors.white),
                items: _sessions.map((String session) {
                  return DropdownMenuItem<String>(
                    value: session,
                    child: Text(session, style: GoogleFonts.poppins()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedSession = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Sesi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 40.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isAvailable ? _processBooking : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isAvailable ? Colors.blue.shade800 : Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    isAvailable ? 'Booking Sekarang' : 'Sudah Di-booking',
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.redAccent.shade100),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
      ),
    );
  }
}
