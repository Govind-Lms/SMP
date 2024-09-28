import 'dart:io';

import 'package:universal_html/html.dart' as html;

import 'dart:ui' as ui;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // Add this import for capturing UI
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:permission_handler/permission_handler.dart'; // For permissions
import 'package:smp/src/core/models/client_model.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';
import 'package:smp/src/presentations/views/voucher/ticket/components/buttons_part.dart';
import 'package:smp/src/presentations/views/voucher/ticket/components/desc_part.dart';
import 'package:smp/src/presentations/views/voucher/ticket/components/owner_part.dart';
import 'package:smp/src/presentations/views/voucher/ticket/components/table_part.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TicketPage extends StatelessWidget {
  final ClientModel clientModel;
  final GlobalKey _globalKey = GlobalKey(); // Key for RepaintBoundary

  TicketPage({super.key, required this.clientModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: RepaintBoundary(
        key: _globalKey,
        child: SafeArea(
          child: ListView(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: TicketWidget(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height - 150,
                    isCornerRounded: true,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const OwnerPart(),
                            BarcodeWidget(
                              data: voucherIdNotifier.value,
                              barcode: Barcode.qrCode(),
                              height: 70,
                              width: 70,
                            ),
                          ],
                        ),
                        const Gap(10),
                        const Spacer(),
                        const TablePart(),
                        const Spacer(),
                        DescriptionPart(clientModel: clientModel),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtonsPart(
        onGenerateImage: () async {
          await _captureImage(context);
        },
      ),
    );
  }

  Future<void> _captureImage(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
        
      if (kIsWeb) {
       
        
        final blob = html.Blob([pngBytes], 'image/png');
        final url = html.Url.createObjectUrlFromBlob(blob);
        
        html.AnchorElement(href: url)
          ..setAttribute('download',
              'voucher_${clientModel.name}_${voucherIdNotifier.value}.png')
          ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        await _saveImageToDevice(pngBytes, context);
      }
    } catch (e) {
        _showToast('Failed to capture image: $e', Colors.red);
    }
  }

  Future<void> _saveImageToDevice(Uint8List pngBytes, BuildContext context) async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.request().isGranted) {
        await _saveAndToast(pngBytes);
      } else {
        _showToast('Storage permission denied', Colors.red);
      }
    } else if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted) {
        await _saveAndToast(pngBytes);
      } else {
        _showToast('Storage permission denied', Colors.red);
      }
    }
  }


  Future<void> _saveAndToast(Uint8List pngBytes) async {
    final result = await ImageGallerySaver.saveImage(pngBytes, quality: 100, name: "voucher_${clientModel.name}${voucherIdNotifier.value}");
    if (result['isSuccess']) {
      _showToast('Image saved to gallery!', Colors.green);
    } else {
      _showToast('Failed to save image', Colors.red);
    }
  }

  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
    );
  }

}
