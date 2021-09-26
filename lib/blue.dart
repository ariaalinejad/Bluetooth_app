import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

final FlutterBlue flutterBlue = FlutterBlue.instance;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _blue(BuildContext context) {
    return FutureBuilder(
        future: blue(),
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return AlertDialog(
            title: const Text('Bluetooth status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(text.requireData),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check bluetooth connection'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _blue(context),
                );
              },
              icon: const Icon(Icons.bluetooth),
              iconSize: 300,
              color: Colors.blueAccent,
              tooltip: 'Check bluetooth connection',
            ),
            const Text(
                'Press the bluetooth icon',
                style: TextStyle(
                  color: Colors.grey,)
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> blue() async {
  try {
    Future<bool> isOn = flutterBlue.isOn;
    if (await isOn == true) {
      return await Future(() => "Bluetooth is on");
    }
    else {
      return await Future(() => "Bluetooth is off");
    }
  }
  on Exception catch (_) {
    return await Future(() => 'Bluetooth is not available on the device');
  }
}
