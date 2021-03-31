import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_earth/service/calendar_service.dart';
import 'package:green_earth/parent_inherit.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:green_earth/json_convertors/calendarDates.dart';

class DateIndicator extends StatefulWidget {
  final List<CalendarDates> datesResultList;
  DateIndicator({this.datesResultList});
  @override
  _DateIndicatorState createState() => _DateIndicatorState();
}

class _DateIndicatorState extends State<DateIndicator> {
  parent_inherit pinherit;
  int selectedDay = 1;
  int monthDateCount = 1;
  Map<int, bool> dayAvailabilityMap = {};


  @override
  Widget build(BuildContext context) {
    String token = parent_inherit.of(context).token;
    List<DateTime> days = [];
    List datesResultList = widget.datesResultList;
    List trueStatusDateList = [];
    List falseStatusDateList = [];
    DateTime initialWeekDate =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    DateTime lastWeekDate = DateTime.now()
        .add(Duration(days: DateTime.daysPerWeek - DateTime.now().weekday));
    print(
        '^^^^^^^^^^^$initialWeekDate ************** $lastWeekDate ^^^^^^^^^^^^');

    final daysToGenerate = (lastWeekDate.add(Duration(days: 1)))
        .difference(initialWeekDate)
        .inDays;
    days = List.generate(
        daysToGenerate,
        (i) => DateTime(initialWeekDate.year, initialWeekDate.month,
            initialWeekDate.day + (i)));
    
    print('**********$days**************');

    for (var i in datesResultList) {
      print("``````````${i.datesMapper}");
      if(i.datesMapper["status"]==true) {
        print("```````````~~~~~~~~~~~~~~~~~~~~~~${i.datesMapper["date"]}");
        trueStatusDateList.add(i.datesMapper["date"]);
      }
    }

    for (var i in datesResultList) {
      if(i.datesMapper["status"]==false) {
        falseStatusDateList.add(i.datesMapper["date"]);
      }
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 4.0, right: 4.0),
          // decoration: BoxDecoration(color: Colors.blue),
          width: MediaQuery.of(context).size.width,
          height: 75.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7, // to avoid showing zero
              itemBuilder: (BuildContext context, int index) {
                return DateHolder(
                  index: index,
                  days: days,
                  falseStatusDateList: falseStatusDateList,
                  trueStatusDateList: trueStatusDateList,
                );
              }),
        ),
      ],
    );


  }
}

class DateHolder extends StatefulWidget {
  final List trueStatusDateList;
  final List falseStatusDateList;
  final List<DateTime> days;
  final int index;
  DateHolder({this.index, this.days, this.trueStatusDateList,this.falseStatusDateList});
  @override
  _DateHolderState createState() => _DateHolderState();
}

class _DateHolderState extends State<DateHolder> {
  CalendarController _controller=CalendarController();
  // final Widget activeBubble = Container(
  //   width: 15.0,
  //   height: 15.0,
  //   decoration: BoxDecoration(
  //     shape: BoxShape.circle,
  //     color: Colors.deepOrangeAccent,
  //   ),
  // );
  //
  // bool _decideWhichDayToEnable(DateTime day) {
  //   if ((day.isAfter(widget.postedDatesString[0].) &&
  //       day.isBefore(DateTime.now().add(Duration(days: 10))))) {
  //     return true;
  //   }
  //   return false;
  // }

  bool picChecker=false;                                   /* ToDo */
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  String toastData(String formatted){
    if(widget.trueStatusDateList.contains(formatted)){
      return "Photo Accepted";
    }
    else if(widget.falseStatusDateList.contains(formatted)){
      return "Photo Rejected";
    }
    else{
      return "In Waiting State";
    }
  }
  Color datesColorSelector(){
    if (DateTime.now().isBefore(widget.days[widget.index]) && ((widget.days[widget.index].day != DateTime.now().day ||
        DateTime.now().difference(widget.days[widget.index]).inHours > 24))){
      return Colors.grey.withOpacity(0.05);
    }
    else if(widget.trueStatusDateList.contains(widget.days[widget.index].toString().substring(0, 10))){
      return Colors.greenAccent;
    }
    else if(widget.falseStatusDateList.contains(widget.days[widget.index].toString().substring(0, 10))){
      return Colors.red;
    }
    else{
      return Colors.amber[300];
    }
  }

  Color tableCalendarDatesColour(String formatted){
    if(widget.trueStatusDateList.contains(formatted)){
      return Colors.greenAccent;
    }
    else if(widget.falseStatusDateList.contains(formatted)){
      return Colors.red;
    }
    else{
      return Colors.amber[300];
    }
  }

  _selectDate(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.green[50],
      children: [
        Container(
            child: TableCalendar(
              onUnavailableDaySelected:()=>null,
              onDaySelected: (date, events, holidays) {
                String formatted = formatter.format(date);
                Fluttertoast.showToast(msg: "${toastData(formatted)}",toastLength: Toast.LENGTH_SHORT);
                },
              availableCalendarFormats: const {CalendarFormat.month : 'Month'},
              calendarStyle: CalendarStyle(
                todayColor: Colors.blue,
                todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple)
              ),
              // startDay: ,
              calendarController:_controller,
              headerStyle: HeaderStyle(centerHeaderTitle: true),
              builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events){
                    String formatted = formatter.format(date);
                    return Container(
                          margin: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              color: tableCalendarDatesColour(formatted),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xff000000),
                                width: 1,
                              )),
                          child: Center(
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                      );
                  },
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xff000000),
                            width: 1,
                          )
                      ),
                      child: Center(
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                dayBuilder: (context,date,events){
                  String formatted = formatter.format(date);
                  return Container(
                    margin: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(shape: BoxShape.circle,color:tableCalendarDatesColour(formatted)),
                    child: Center(child: Text(date.day.toString(),style: TextStyle(color: Colors.white),)),

                  );
                }
              ),
            )
        )
    ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // final appState = DateIndicator.of(context);
    print(
        '!!!!!!!!!!!!${widget.trueStatusDateList}%%%%%%%%%%%%%%${widget.days[widget.index].toString().substring(0, 10)}');
    print(
        '!!!!!!!!!!!!${widget.falseStatusDateList}%%%%%%%%%%%%%%${widget.days[widget.index].toString().substring(0, 10)}');
    return InkWell(
      onTap: () {
        // appState.toggleDateHolderActive(true);
        // appState.setSelectedDay(index);
        showDialog(context: context,builder: (BuildContext context) => _selectDate(context));
        // _selectDate(context);
        print("Date ${widget.index} selected!");
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 64) / 7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: datesColorSelector()),
        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            Text(
              "${DateFormat('EEEE').format(widget.days[widget.index]).substring(0, 3)}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16.0),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              '${widget.days[widget.index].day}',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            )
          ],
        ),
      ),
      // (appState.dayAvailabilityMap[index] ?? false)
      //     ? Positioned(right: 8.0, bottom: 5.0, child: activeBubble)
      //     : Container(),
    );
  }
}
