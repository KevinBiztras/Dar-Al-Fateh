import 'package:flutter/material.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'dart:io';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class MobileScannerSimple extends StatefulWidget {
  const MobileScannerSimple({super.key});

  @override
  State<MobileScannerSimple> createState() => _MobileScannerSimpleState();
}

class _MobileScannerSimpleState extends State<MobileScannerSimple> {
  bool _scanned = false;
  bool _cameraAllowed = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    var status = await Permission.camera.status;

    if (status.isGranted) {
      setState(() => _cameraAllowed = true);
    } else if (status.isDenied) {
      var newStatus = await Permission.camera.request();
      if (newStatus.isGranted) {
        setState(() => _cameraAllowed = true);
      }
    }
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (_scanned) return;

    final items = barcodes.barcodes;
    if (items.isNotEmpty) {
      final code = items.first.displayValue ?? "";
      if (code.isNotEmpty) {
        _scanned = true;
        Navigator.of(context).pop(code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scanWindowWidth = size.width * 0.9;
    final scanWindowHeight = size.height * 0.20;

    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: !_cameraAllowed
          ? Center(
              child: Text(
                AppLocalizations.of(context)?.translate("cameraPermission") ??
                    "",
                style: TextStyle(color: Colors.white),
              ),
            )
          : Stack(
              children: [
                MobileScanner(
                  onDetect: _handleBarcode,
                  scanWindow: Rect.fromCenter(
                    center: Offset(size.width / 2, size.height / 2),
                    width: scanWindowWidth,
                    height: scanWindowHeight,
                  ),
                ),

                // Green scanner border
                Center(
                  child: Container(
                    width: scanWindowWidth,
                    height: scanWindowHeight,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.greenAccent.withOpacity(0.8),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
