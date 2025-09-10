import 'dart:convert';
import 'dart:typed_data';
import 'package:absensi_pegawai/features/absensi/presentation/bloc/sakit/sakit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

Future<String?> capturePhotoBase64(
  BuildContext context,
  bool isSuratDokter,
) async {
  final picker = ImagePicker();

  while (true) {
    final file = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 85, // kompres sedikit
    );
    if (file == null) return null; // user batal

    final bytes = await file.readAsBytes();
    final ok = await _showPreview(context, bytes);
    if (ok == true) {
      if (isSuratDokter) {
        context.read<SakitBloc>().add(
          SetPathAndBase64(
            path: p.basename(file.path),
            base64: base64Encode(bytes),
          ),
        );
      }
      return base64Encode(bytes);
    }
    // kalau Retake -> loop lagi
  }
}

Future<bool?> _showPreview(BuildContext context, Uint8List bytes) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return Dialog(
        backgroundColor: const Color(0xff1b1e3a),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Preview Photo',
              style: TextStyle(
                color: Color(0xffE5E7EB),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                bytes,
                fit: BoxFit.cover,
                width: 280,
                height: 280,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text(
                      'Retake',
                      style: TextStyle(color: Color(0xff9CA3AF)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff343c60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text(
                      'Pakai Foto',
                      style: TextStyle(color: Color(0xffE5E7EB)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      );
    },
  );
}
