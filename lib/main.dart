import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderColor(),
      child: const Main(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = context.watch<ProviderColor>();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: data.appBarBgColor,
          title: Column(
            children: const [
              SwitchThem(),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverGrid(
              delegate: SliverChildListDelegate(
                [
                  ...List.generate(
                    data.themColor.length,
                    ((index) => Container(
                          color: data.themColor[index],
                        )),
                  ),
                ],
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProviderColor extends ChangeNotifier {
  bool isActive = false;
  Color appBarBgColor = Colors.amber;

  final List<Color> colorsOne = [
    Colors.amber,
    Colors.black,
    Colors.green,
    Colors.grey,
    Colors.purple,
    Colors.blue,
    Colors.teal,
    Colors.orange,
    Colors.pink,
    Colors.lime,
  ];

  final List<Color> colorsTwo = [
    Colors.tealAccent,
    Colors.red,
    Colors.pinkAccent,
    Colors.lightGreen,
    Colors.deepOrangeAccent,
    Colors.cyanAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.limeAccent,
  ];

  late List<Color> themColor = colorsOne;

  void change(bool val) {
    isActive = val;
    isActive ? appBarBgColor = Colors.black : appBarBgColor = Colors.amber;
    isActive ? themColor = colorsTwo : themColor = colorsOne;
    notifyListeners();
  }

  final snackBar = SnackBar(
    content: const Text(
      'ХОБА !',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 25),
    ),
    duration: const Duration(milliseconds: 500),
    backgroundColor: Colors.blueGrey.withOpacity(0.8),
  );
}

class SwitchThem extends StatelessWidget {
  const SwitchThem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data = context.watch<ProviderColor>();
    return Switch(
      activeColor: Colors.amber,
      activeTrackColor: Colors.amber,
      value: data.isActive,
      onChanged: (value) {
        data.change(value);
        ScaffoldMessenger.of(context).showSnackBar(data.snackBar);
      },
    );
  }
}
