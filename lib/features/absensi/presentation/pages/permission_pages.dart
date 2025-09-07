import 'package:absensi_pegawai/features/absensi/data/models/history_cuti_model.dart';
import 'package:absensi_pegawai/features/absensi/presentation/pages/history_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:siqma_field/siqma_field.dart';

import '../bloc/cuti/cuti_bloc.dart';

class PermissionPages extends StatefulWidget {
  const PermissionPages({super.key});

  @override
  State<PermissionPages> createState() => _PermissionPagesState();
}

class _PermissionPagesState extends State<PermissionPages> {
  final keperluanController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final sickDateController = TextEditingController();
  final keteranganController = TextEditingController();

  bool isCuti = false;

  void onCuti(bool value) {
    setState(() {
      isCuti = value;
    });
  }

  @override
  void dispose() {
    keperluanController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    sickDateController.dispose();
    keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.paddingOf(context).top + 20,
              bottom: 12,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Icon(CupertinoIcons.time, color: Colors.transparent),
                  ),
                  Text(
                    'Perizinan',
                    style: TextStyle(
                      color: Color(0xffE5E7EB),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Icon(CupertinoIcons.time, color: Color(0xff343c60)),
                        CircleAvatar(backgroundColor: Colors.red, radius: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //TAB BAR
        SliverToBoxAdapter(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: !isCuti ? Color(0xff343c60) : null,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      onCuti(false);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Text(
                        ' Cuti ',
                        style: TextStyle(
                          color: Color(0xffE5E7EB),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Material(
                  borderRadius: BorderRadius.circular(8),
                  color: isCuti ? Color(0xff343c60) : null,
                  child: InkWell(
                    onTap: () {
                      onCuti(true);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Text(
                        'Sakit',
                        style: TextStyle(
                          color: Color(0xffE5E7EB),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        ...tabBarWidget(isCuti),
      ],
    );
  }

  List<Widget> tabBarWidget(bool isCuti) {
    return !isCuti ? cutiWidget() : sakitWidget();
  }

  //CUTI
  List<Widget> cutiWidget() {
    return [
      //INFORMASI SAKIT
      BlocBuilder<CutiBloc, CutiState>(
        builder: (context, state) {
          int? quotaCuti = state.quotaCuti?.remainingDay;
          return SliverToBoxAdapter(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(136, 52, 60, 96),
                  ),
                ),
                SizedBox(
                  width: 240,
                  height: 240,
                  child: Image.asset("assets/calendar.webp"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18, right: 5),
                  child: Text(
                    quotaCuti != null ? quotaCuti.toString() : '0',
                    style: TextStyle(
                      color: Color(0xff343c60),
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  child: Text(
                    'Jatah Cuti Tersisa : ${quotaCuti ?? '0'} hari',
                    style: TextStyle(
                      color: Color(0xffE5E7EB),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      //FORM PENGAJUAN
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SiqmaField(
                label: 'Keperluan',
                controller: keperluanController,
                borderColor: Color.fromARGB(30, 229, 231, 235),
                fontStyle: TextStyle(color: Color(0xffE5E7EB)),
              ),
              SizedBox(height: 16),
              SiqmaField(
                label: 'Start',
                controller: startDateController,
                hintText: '17/06/2025',
                hintStyle: TextStyle(color: Color(0xff6B7280)),
                borderColor: Color.fromARGB(30, 229, 231, 235),
                fontStyle: TextStyle(color: Color(0xffE5E7EB)),
                suffixIcon: GestureDetector(
                  onTap: () {
                    showCupertinoModalPopUp(startDateController);
                  },
                  child: Icon(
                    CupertinoIcons.calendar,
                    color: Color.fromARGB(181, 72, 52, 119),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SiqmaField(
                label: 'End',
                controller: endDateController,
                hintText: '17/08/2025',
                hintStyle: TextStyle(color: Color(0xff6B7280)),
                borderColor: Color.fromARGB(30, 229, 231, 235),
                fontStyle: TextStyle(color: Color(0xffE5E7EB)),
                suffixIcon: GestureDetector(
                  onTap: () {
                    showCupertinoModalPopUp(endDateController);
                  },
                  child: Icon(
                    CupertinoIcons.calendar,
                    color: Color.fromARGB(181, 72, 52, 119),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Material(
                color: Color(0xff343c60),
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  focusColor: Color(0xff343c60),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Center(
                      child: Text(
                        'Ajukan Cuti',
                        style: TextStyle(
                          color: Color(0xffE5E7EB),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Riwayat Pengajuan Cuti',
                style: TextStyle(
                  color: Color(0xffE5E7EB),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // DropdownButton(
              //   value: null,
              //   items: [
              //     DropdownMenuItem(child: Text('Approved'), value: 'Approved'),
              //     DropdownMenuItem(child: Text('Rejected'), value: 'Rejected'),
              //     DropdownMenuItem(child: Text('Pending'), value: 'Pending'),
              //   ],
              //   onChanged: (value) {},
              // ),
            ],
          ),
        ),
      ),

      BlocBuilder<CutiBloc, CutiState>(
        builder: (context, state) {
          final data = state.listHistoryCuti;
          return data != null
              ? SliverList.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => Container(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(142, 52, 60, 96),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tanggal Cuti: ${formatDateRange(data[index].startDate, data[index].endDate)}',
                              style: TextStyle(
                                color: Color(0xffE5E7EB),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              data[index].reason,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Diperbarui : ${formatUpdatedAt(data[index].decidedAt)}',
                                      style: TextStyle(
                                        color: Color(0xff9CA3AF),
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      'Dibuat : ${formatUpdatedAt(data[index].createdAt)}',
                                      style: TextStyle(
                                        color: Color(0xff9CA3AF),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: data[index].status.color,
                                  ),
                                  child: Text(
                                    data[index].status.label,
                                    style: TextStyle(
                                      color: Color(0xffE5E7EB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SliverToBoxAdapter();
        },
      ),
    ];
  }

  //SAKIT
  List<Widget> sakitWidget() {
    return [
      //FORM PENGAJUAN
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SiqmaField(
                label: 'Tanggal Sakit',
                controller: sickDateController,
                hintText: '17/08/2025',
                hintStyle: TextStyle(color: Color(0xff6B7280)),
                borderColor: Color.fromARGB(30, 229, 231, 235),
                fontStyle: TextStyle(color: Color(0xffE5E7EB)),
                suffixIcon: GestureDetector(
                  onTap: () {
                    showCupertinoModalPopUp(sickDateController);
                  },
                  child: Icon(
                    CupertinoIcons.calendar,
                    color: Color.fromARGB(181, 72, 52, 119),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color.fromARGB(30, 229, 231, 235)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(30, 229, 231, 235),
                      ),
                      child: Icon(
                        CupertinoIcons.tray_arrow_down,
                        color: Color.fromARGB(106, 229, 231, 235),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lampirkan Surat Dokter (Foto)'),
                        Text(
                          'JPG, PNG, HEIC',
                          style: TextStyle(color: Color(0xff6B7280)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              SiqmaField(
                label: 'Keterangan (Opsional)',
                controller: keperluanController,
                maxLines: 4,
                minLines: 1,
                borderColor: Color.fromARGB(30, 229, 231, 235),
                fontStyle: TextStyle(color: Color(0xffE5E7EB)),
              ),
              SizedBox(height: 16),
              Material(
                color: Color(0xff343c60),
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  focusColor: Color(0xff343c60),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Center(
                      child: Text(
                        'Izin Sakit',
                        style: TextStyle(
                          color: Color(0xffE5E7EB),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  showCupertinoModalPopUp(TextEditingController controller) {
    final formatter = DateFormat('dd/MM/yyyy');
    DateTime? initialDate;

    if (controller.text.isNotEmpty) {
      try {
        initialDate = formatter.parse(controller.text);
      } catch (_) {
        initialDate = DateTime.now();
      }
    } else {
      initialDate = DateTime.now();
    }

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Color(0xff10122a),
          ),
          width: MediaQuery.sizeOf(context).width,
          child: CupertinoDatePicker(
            backgroundColor: Color(0xff10122a),
            initialDateTime: initialDate,
            dateOrder: DatePickerDateOrder.dmy,
            use24hFormat: true,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              print(value);
              controller.text = formatter.format(value);
            },
          ),
        );
      },
    );
  }

  String formatUpdatedAt(DateTime value) {
    // Parse string ISO8601
    final dateTime = value.toLocal();

    // Format jam:menit (24 jam)
    final time = DateFormat.Hm().format(dateTime);

    // Format tanggal dengan nama bulan singkat (id_ID → bahasa Indonesia)
    final date = DateFormat("d MMM yyyy", "id_ID").format(dateTime);

    return "$time, $date";
  }

  String formatDateRange(DateTime start, DateTime end) {
    // Kalau bulan dan tahun sama → tampilkan ringkas
    if (start.month == end.month && start.year == end.year) {
      final dayRange = "${start.day} - ${end.day}";
      final monthYear = DateFormat("MMM yyyy", "en_US").format(start);
      return "$dayRange $monthYear";
    }

    // Kalau beda bulan/tahun → tampilkan lengkap
    final startFmt = DateFormat("d MMM yyyy", "en_US").format(start);
    final endFmt = DateFormat("d MMM yyyy", "en_US").format(end);
    return "$startFmt - $endFmt";
  }
}
