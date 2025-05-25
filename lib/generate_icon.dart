import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'widgets/app_icon_painter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  const size = Size(1024, 1024);

  // Draw the icon
  AppIconPainter().paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final buffer = byteData!.buffer.asUint8List();

  // Save the main icon
  File('assets/icon/icon.png').writeAsBytesSync(buffer);

  // Save the foreground icon (same as main icon for adaptive icons)
  File('assets/icon/icon_foreground.png').writeAsBytesSync(buffer);

  print('Icons generated successfully!');
  exit(0);
}
