
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/models/booking_model.dart';

class RoomProvider with ChangeNotifier {
  final Map<String, bool> _roomStatus = {
    ...List.generate(15, (index) => 'R${index + 1}').asMap().map((_, v) => MapEntry(v, true)),
    ...List.generate(15, (index) => 'L${index + 1}').asMap().map((_, v) => MapEntry(v, true)),
    'SG1': true,
  };

  List<Booking> _bookings = [];

  Map<String, bool> get roomStatus => _roomStatus;
  List<Booking> get bookings => _bookings;

  RoomProvider() {
    _loadBookings();
  }

  // Load bookings from shared preferences
  Future<void> _loadBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final bookingsJson = prefs.getStringList('bookings') ?? [];
    _bookings = bookingsJson.map((json) => Booking.fromJson(json)).toList();

    // Update room status based on loaded bookings
    for (var booking in _bookings) {
      _roomStatus[booking.roomId] = false;
    }
    notifyListeners();
  }

  // Save bookings to shared preferences
  Future<void> _saveBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final bookingsJson = _bookings.map((booking) => booking.toJson()).toList();
    await prefs.setStringList('bookings', bookingsJson);
  }

  // Add a new booking
  Future<void> addBooking(Booking booking) async {
    _roomStatus[booking.roomId] = false;
    _bookings.add(booking);
    await _saveBookings();
    notifyListeners();
  }

  // Clear all bookings (optional, for debugging or admin purposes)
  Future<void> clearAllBookings() async {
    _bookings.clear();
    for (var key in _roomStatus.keys) {
      _roomStatus[key] = true;
    }
    await _saveBookings();
    notifyListeners();
  }
}
