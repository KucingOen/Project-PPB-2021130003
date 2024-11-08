class Schedule {
  final String namaMatkul;
  final int hari;
  final String jamMulai;
  final String jamSelesai;
  final String kelas;
  final String ruang;
  final String dosen;

  Schedule({
    required this.namaMatkul,
    required this.hari,
    required this.jamMulai,
    required this.jamSelesai,
    required this.kelas,
    required this.ruang,
    required this.dosen
  });

  // Convert the Schedule instance to a map (useful for JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'courseName': namaMatkul,
      'day': hari,
      'startTime': jamMulai,
      'endTime': jamSelesai,
      'class': kelas,
      'room': ruang,
      'lecturer': dosen,
    };
  }

  // Factory constructor to create an Schedule from a Firebase snapshot
  factory Schedule.fromMap(Map<dynamic, dynamic> data) {
    return Schedule(
      namaMatkul: data['courseName'] ?? '',
      hari: (data['day'] ?? 0),
      jamMulai: data['startTime'] ?? '',
      jamSelesai: data['endTime'] ?? '',
      kelas: data['class'] ?? '',
      ruang: data['room'] ?? '',
      dosen: data['lecturer'] ?? '',
    );
  }
}