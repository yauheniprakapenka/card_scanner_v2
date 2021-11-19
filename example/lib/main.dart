import 'package:card_scanner/card_scanner.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var card = ScannedCardModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(card.toString()),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () async {
        await _scanCard();
      },
      child: const Text('Scan card'),
    );
  }

  Future<void> _scanCard() async {
    const scanOptions = ScanOptions(scanCardHolderName: true);
    try {
      final receivedCard = await CardScanner.scanCard(scanOptions: scanOptions);
      if (receivedCard == null) return;
      if (!mounted) return;
      card = receivedCard;
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
