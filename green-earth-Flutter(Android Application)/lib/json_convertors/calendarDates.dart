class CalendarDates{
  final Map<String,dynamic> datesMapper;

  CalendarDates(this.datesMapper);

  CalendarDates.fromJson(Map<String, dynamic> json)
    : datesMapper={"status":json['status'],"date":json['datedata'].toString().substring(0,10)};

}