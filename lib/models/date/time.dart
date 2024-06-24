class MyTime {
  DateTime initialDate;
  DateTime finalDate;

  MyTime({required this.initialDate, required this.finalDate});

// days left for assignment delivery

// current  time or hous
  DateTime currentDate = DateTime.now();

  // calcular diferencia de dias y horas

  String timeDiference() {
    Duration timeDifference = finalDate.difference(initialDate);
    int days = timeDifference.inDays;
    int hous = timeDifference.inHours % 24;
    int minutes = timeDifference.inMinutes % 60;

    return "${days.toString()} Dias   |   ${hous.toString()} horas  |  ${minutes.toString()} Minutos";
  }

  String get daysToSubmitAssignment => timeDiference();
}
