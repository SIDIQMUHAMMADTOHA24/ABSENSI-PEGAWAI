import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../domain/entities/attendance_day_detail.dart';
import '../bloc/calender/calender_bloc.dart';

class AttendancePages extends StatefulWidget {
  const AttendancePages({super.key});

  @override
  State<AttendancePages> createState() => _AttendancePagesState();
}

class _AttendancePagesState extends State<AttendancePages> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  final _fmtDay = DateFormat('yyyy-MM-dd');
  final _fmtTime = DateFormat('HH:mm:ss');

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
  }

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
          _calenderWidget(),
          BlocBuilder<CalenderBloc, CalenderState>(
            builder: (context, state) {
              final detail = state.dayDetail;

              if (state.detailLoading) {
                return SliverList.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => shimmerWidget(),
                );
              }

              if (detail == null || detail.events.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(142, 52, 60, 96),
                      ),
                      child: const Text(
                        "Belum ada absensi pada tanggal ini.",
                        style: TextStyle(
                          color: Color(0xffE5E7EB),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              }

              return SliverList.builder(
                itemCount: detail.events.length,
                itemBuilder: (context, index) {
                  final ev = detail.events[index];
                  final isIn = ev.type == AttendanceEventType.checkIn;
                  final label = isIn ? 'Waktu check in' : 'Waktu check out';
                  final timeStr = _fmtTime.format(ev.at.toLocal());
                  return historyWidget(label: label, value: timeStr);
                },
              );
            },
          ),

          // (opsional) Worked seconds ringkas
          BlocBuilder<CalenderBloc, CalenderState>(
            builder: (context, state) {
              if (state.detailLoading) {
                return SliverToBoxAdapter();
              }

              final ws = state.dayDetail?.workedSeconds ?? 0;
              if (ws <= 0) return const SliverToBoxAdapter(child: SizedBox());
              final h = ws ~/ 3600;
              final m = (ws % 3600) ~/ 60;
              final s = ws % 60;
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Text(
                    "Durasi kerja: ${h}j ${m}m ${s}d",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color(0xff9CA3AF),
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _calenderWidget() {
    return BlocBuilder<CalenderBloc, CalenderState>(
      builder: (context, state) {
        final marks = state.marks;
        final presentSet = <String>{};
        if (marks != null) {
          for (var i in marks.daysPresent) {
            presentSet.add(_fmtDay.format(i.toLocal()));
          }
        }

        List eventLoader(DateTime time) {
          final key = _fmtDay.format(time);
          return presentSet.contains(key) ? [1] : [];
        }

        return SliverToBoxAdapter(
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
              focusedDay: _focusedDay,
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
                markersMaxCount: 1,
                cellMargin: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 2,
                ),
                defaultTextStyle: const TextStyle(color: Color(0xffE5E7EB)),
                weekendTextStyle: const TextStyle(color: Color(0xffE5E7EB)),

                // >>> semua consistent rectangle (tidak ada shape: BoxShape.circle)
                defaultDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                weekendDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                outsideDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                todayDecoration: BoxDecoration(
                  color: const Color(0xff6366F1).withOpacity(.25),
                  borderRadius: BorderRadius.circular(4),
                ),
                selectedDecoration: BoxDecoration(
                  color: const Color(0xff6366F1),
                  borderRadius: BorderRadius.circular(4),
                ),
                rangeStartDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                rangeEndDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                withinRangeDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),

                markerDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xFF10B981),
                ),
              ),
              selectedDayPredicate: (day) =>
                  _selectedDay != null &&
                  _fmtDay.format(day) == _fmtDay.format(_selectedDay!),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                context.read<CalenderBloc>().add(LoadDay(date: selectedDay));
              },
              onPageChanged: (focusedDay) {
                setState(() => _focusedDay = focusedDay);
                context.read<CalenderBloc>().add(
                  LoadMonth(monthAnchor: focusedDay),
                );
              },
              eventLoader: eventLoader,
            ),
          ),
        );
      },
    );
  }

  Widget historyWidget({String? label, String? value}) {
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
            label ?? '',
            style: const TextStyle(color: Color(0xffE5E7EB), fontSize: 16),
          ),
          Text(
            value ?? '',
            style: const TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget shimmerWidget() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2B304F),
      highlightColor: const Color(0xFF3B4270),
      child: Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(142, 52, 60, 96),
        ),
        height: 58,
      ),
    );
  }
}
