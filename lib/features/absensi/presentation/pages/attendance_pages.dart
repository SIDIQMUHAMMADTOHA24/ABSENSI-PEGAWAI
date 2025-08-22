import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendancePages extends StatefulWidget {
  const AttendancePages({super.key});

  @override
  State<AttendancePages> createState() => _AttendancePagesState();
}

class _AttendancePagesState extends State<AttendancePages> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Kalender",
                  style: TextStyle(
                    color: Color(0xffE5E7EB),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xff1b1e3a),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.now(),
                focusedDay: DateTime.now(),
                calendarFormat: CalendarFormat.month,
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  rightChevronMargin: EdgeInsets.all(0),
                  leftChevronMargin: EdgeInsets.all(0),
                  rightChevronPadding: EdgeInsets.all(0),
                  leftChevronPadding: EdgeInsets.all(0),
                  headerMargin: EdgeInsets.only(bottom: 12),
                  titleTextStyle: const TextStyle(
                    color: Color(0xffE5E7EB),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  leftChevronIcon: const Icon(
                    CupertinoIcons.back,
                    color: Color(0xffE5E7EB),
                  ),
                  rightChevronIcon: const Icon(
                    CupertinoIcons.forward,
                    color: Color(0xffE5E7EB),
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Color(0xff9CA3AF)),
                  weekendStyle: TextStyle(color: Color(0xff9CA3AF)),
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  cellMargin: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                  defaultTextStyle: const TextStyle(color: Color(0xffE5E7EB)),
                  weekendTextStyle: const TextStyle(color: Color(0xffE5E7EB)),
                  todayDecoration: BoxDecoration(
                    color: Color(0xff6366F1).withOpacity(.25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xff6366F1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  markerDecoration: BoxDecoration(
                    color: Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemBuilder: (context, index) {
              return historyWidget();
            },
            itemCount: 10,
          ),
        ],
      ),
    );
  }

  Widget historyWidget() {
    return Container(
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromARGB(142, 52, 60, 96),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '17-08-2025',
            style: const TextStyle(color: Color(0xffE5E7EB), fontSize: 16),
          ),
          Text(
            "Check In",
            style: const TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
          ),
        ],
      ),
    );
  }
}
