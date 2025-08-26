import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> captureSelfieBase64(BuildContext context) async {
  final picker = ImagePicker();

  while (true) {
    final file = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 85, // kompres sedikit
    );
    if (file == null) return null; // user batal

    final bytes = await file.readAsBytes();
    final ok = await _showPreview(context, bytes);
    if (ok == true) {
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
              'Preview Selfie',
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
