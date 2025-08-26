import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/status/status_bloc.dart';

class DashboardPages extends StatelessWidget {
  const DashboardPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.paddingOf(context).top,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: Text(
                "PT Migas Darma Nusantara",
                style: TextStyle(
                  color: Color(0xffE5E7EB),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // ==== ACTION CHIP ====
          chipActionWidget(),

          // ==== LOCATION CHIP ====
          chipLocationWidget(),
        ],
      ),
    );
  }

  SliverToBoxAdapter chipActionWidget() {
    return SliverToBoxAdapter(
      child: BlocBuilder<StatusBloc, StatusState>(
        builder: (context, state) {
          // SAFETY DEFAULTS
          final inside = state.inside ?? false;
          final radius = state.radiusM ?? 0;

          final inAt = state.checkInAt;
          final outAt = state.checkOutAt;

          final checkIn = (inAt != null)
              ? '- ${DateFormat('HH:mm:ss').format(inAt.toLocal())}'
              : '-';
          final checkOut = (outAt != null)
              ? '- ${DateFormat('HH:mm:ss').format(outAt.toLocal())}'
              : '-';

          // ENABLE/DISABLE BUTTON
          final canCheckIn = inside && inAt == null;
          final canCheckOut = inside && inAt != null && outAt == null;

          return Container(
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
                          border: Border.all(
                            color: Color(0xffE5E7EB),
                            width: 2,
                          ),
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
                          style: TextStyle(
                            color: Color(0xff9CA3AF),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          inside ? "Di dalam area" : "Di luar area",
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
                        children: [
                          const Text(
                            "Hari ini",
                            style: TextStyle(
                              color: Color(0xff9CA3AF),
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Radius $radius m",
                            style: const TextStyle(
                              color: Color(0xff9CA3AF),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('d MMMM y', 'en_US').format(DateTime.now()),
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
                            checkIn,
                            style: const TextStyle(
                              color: Color(0xff9CA3AF),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            checkOut,
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
                      child: Material(
                        color: canCheckIn
                            ? const Color(0xff343c60)
                            : Color(0xff1e213a),
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: canCheckIn
                              ? () => context.read<StatusBloc>().add(
                                  const RequestCheckIn(),
                                )
                              : null,
                          focusColor: canCheckIn
                              ? const Color(0xff343c60)
                              : Color(0xff1e213a),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
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
                      child: Material(
                        color: canCheckOut
                            ? const Color(0xff343c60)
                            : const Color(0xff1e213a),
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: canCheckOut
                              ? () => context.read<StatusBloc>().add(
                                  const RequestCheckOut(),
                                )
                              : null,
                          borderRadius: BorderRadius.circular(8),
                          focusColor: canCheckOut
                              ? const Color(0xff343c60)
                              : const Color(0xff1e213a),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
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
          );
        },
      ),
    );
  }

  SliverToBoxAdapter chipLocationWidget() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xff232544),
          borderRadius: BorderRadius.circular(20),
        ),
        child: BlocBuilder<StatusBloc, StatusState>(
          builder: (context, state) {
            return Column(
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
                      "Lat: ${state.userLat ?? '-'}",
                      style: const TextStyle(
                        color: Color(0xffE5E7EB),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Long: ${state.userLng ?? '-'}",
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
                      "${state.distanceM?.toStringAsFixed(1) ?? '0'} m",
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
                        color: (state.inside ?? false)
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                      ),
                      child: Text(
                        (state.inside ?? false)
                            ? "Di dalam area"
                            : "Di luar area",
                        style: TextStyle(
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
                      "Lat: ${state.officeLat ?? '-'}",
                      style: TextStyle(color: Color(0xffE5E7EB), fontSize: 18),
                    ),
                    Text(
                      "Long: ${state.officeLng ?? '-'}",
                      style: TextStyle(color: Color(0xffE5E7EB), fontSize: 18),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
