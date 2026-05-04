import 'dart:convert';

class Booking {
  final String roomId;
  final String studentName;
  final String session;
  final DateTime bookingTime;

  Booking({
    required this.roomId,
    required this.studentName,
    required this.session,
    required this.bookingTime,
  });

  // Convert a Booking object into a map.
  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'studentName': studentName,
      'session': session,
      'bookingTime': bookingTime.toIso8601String(),
    };
  }

  // Create a Booking object from a map.
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      roomId: map['roomId'],
      studentName: map['studentName'],
      session: map['session'],
      bookingTime: DateTime.parse(map['bookingTime']),
    );
  }

  // Convert a Booking object into a JSON string.
  String toJson() => json.encode(toMap());

  // Create a Booking object from a JSON string.
  factory Booking.fromJson(String source) => Booking.fromMap(json.decode(source));
}
