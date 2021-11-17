import 'package:flutter/services.dart';
import 'card_scanner.dart';

class CardScanner {
  static const MethodChannel _channel = const MethodChannel('card_scanner_method');

  static Future<ScannedCardModel?> scanCard({ScanOptions? scanOptions}) async {
    scanOptions ??= ScanOptions();
    final scanResult = await _channel.invokeMapMethod<String, dynamic>('scan_card', scanOptions.map);
    if (scanResult != null) return ScannedCardModel.fromJson(scanResult);
    return null;
  }
}
