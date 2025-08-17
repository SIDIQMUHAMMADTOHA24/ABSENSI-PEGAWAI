import 'package:absensi_pegawai/bloc/attendance/attendance_bloc.dart';
import 'package:absensi_pegawai/repository/attendance_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  String _fmt(DateTime? dt) {
    if (dt == null) return '—';
    two(int n) => n.toString().padLeft(2, '0');
    final d = dt;
    return '${d.year}-${two(d.month)}-${two(d.day)} ${two(d.hour)}:${two(d.minute)}:${two(d.second)}';
  }

  String _time(DateTime? dt) {
    if (dt == null) return '—';
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(dt.hour)}:${two(dt.minute)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10122a),
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listenWhen: (p, c) => c.toast != null,
        listener: (context, state) {
          final msg = state.toast!;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(msg)));
        },
        builder: (context, state) {
          final bloc = context.read<AttendanceBloc>();
          final canCheckIn = state.inside && state.checkInAt == null;
          final canCheckOut =
              state.inside &&
              state.checkInAt != null &&
              state.checkOutAt == null;

          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.paddingOf(context).top,
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "PT Nikel Prima Gemilang",
                      style: TextStyle(
                        color: Color(0xffE5E7EB),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // ==== ACTION CHIP ====
                chipActionWidget(state, canCheckIn, bloc, canCheckOut),

                // ==== LOCATION CHIP ====
                chipLocationWidget(state),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: 'Calender',
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter chipActionWidget(
    AttendanceState state,
    bool canCheckIn,
    AttendanceBloc bloc,
    bool canCheckOut,
  ) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff252745), Color(0xff483477)],
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xff392d62),
                  child: Container(
                    width: 20,
                    height: 20,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Color(0xffE5E7EB), width: 2),
                    ),
                    child: CircleAvatar(backgroundColor: Color(0xffE5E7EB)),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Status",
                      style: TextStyle(color: Color(0xff9CA3AF), fontSize: 16),
                    ),
                    Text(
                      state.inside ? "Di dalam area" : "Di luar area",
                      style: const TextStyle(
                        color: Color(0xffE5E7EB),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(23, 229, 231, 235),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Hari ini",
                        style: TextStyle(
                          color: Color(0xff9CA3AF),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Radius 20 m",
                        style: TextStyle(
                          color: Color(0xff9CA3AF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    // contoh tanggal (silakan ganti dengan intl DateFormat)
                    _fmt(DateTime.now()).split(' ').first,
                    style: const TextStyle(
                      color: Color(0xffE5E7EB),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "- ${_time(state.checkInAt)}",
                        style: const TextStyle(
                          color: Color(0xff9CA3AF),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "- ${_time(state.checkOutAt)}",
                        style: const TextStyle(
                          color: Color(0xff9CA3AF),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Pastikan Anda berada didalam radius kantor untuk melakukan Check In/Out",
              style: TextStyle(color: Color(0xffE5E7EB), fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Opacity(
                    opacity: canCheckIn ? 1 : .5,
                    child: GestureDetector(
                      onTap: canCheckIn
                          ? () {
                              print('can check in');
                              bloc.add(CheckInPressed());
                            }
                          : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: (state.checkInAt == null)
                              ? const Color(0xff343c60)
                              : Color(0xff1e213a),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Check In",
                          style: TextStyle(
                            color: Color(0xffE5E7EB),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Opacity(
                    opacity: canCheckOut ? 1 : .5,
                    child: GestureDetector(
                      onTap: canCheckOut
                          ? () {
                              bloc.add(CheckOutPressed());
                            }
                          : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              (state.checkInAt != null &&
                                  state.checkOutAt == null)
                              ? const Color(0xff343c60)
                              : const Color(0xff1e213a),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Check Out",
                          style: TextStyle(
                            color: Color(0xffE5E7EB),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter chipLocationWidget(AttendanceState state) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xff232544),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Lokasi Anda",
              style: TextStyle(color: Color(0xff9CA3AF), fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lat: ${state.lat?.toStringAsFixed(6) ?? '—'}",
                  style: const TextStyle(
                    color: Color(0xffE5E7EB),
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Long: ${state.lon?.toStringAsFixed(6) ?? '—'}",
                  style: const TextStyle(
                    color: Color(0xffE5E7EB),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Jarak ke Kantor:",
                  style: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                ),
                Text(
                  state.distanceM != null
                      ? "${state.distanceM!.toStringAsFixed(1)} m"
                      : "—",
                  style: const TextStyle(
                    color: Color(0xff9CA3AF),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: state.inside
                        ? const Color(0xFF10B981)
                        : const Color(0xFFEF4444),
                  ),
                  child: Text(
                    state.inside ? "Di dalam area" : "Di luar area",
                    style: const TextStyle(
                      color: Color(0xffE5E7EB),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Color.fromARGB(23, 229, 231, 235)),
            const SizedBox(height: 4),
            const Text(
              "Lokasi Kantor",
              style: TextStyle(color: Color(0xff9CA3AF), fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lat: ${AttendanceRepository.officeLat}",
                  style: TextStyle(color: Color(0xffE5E7EB), fontSize: 18),
                ),
                Text(
                  "Long: ${AttendanceRepository.officeLon}",
                  style: TextStyle(color: Color(0xffE5E7EB), fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
