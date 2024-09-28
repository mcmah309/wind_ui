import 'package:flutter/material.dart';
import 'package:wind_ui/wind_ui.dart';

final appTheme = AppTheme();

class AppTheme extends FullTheme {}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme.createMaterialThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: body ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
      floatingActionButton: body != null
          ? null
          : FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) => setState(() {
                switch (value) {
                  case 0:
                    body = null;
                    _currentIndex = 0;
                  case 1:
                    body = const TextTest();
                    _currentIndex = 1;
                  default:
                    body = null;
                    _currentIndex = 0;
                }
              }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.text_format), label: "Text Test")
          ]),
    );
  }
}

class TextTest extends StatelessWidget {
  const TextTest({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              children: [
                const Text("Normal"),
                linesNormal(appTheme.textXs),
                linesNormal(appTheme.textSm),
                linesNormal(appTheme.textBase),
                linesNormal(appTheme.textLg),
                linesNormal(appTheme.textXl),
                linesNormal(appTheme.text2Xl),
                linesNormal(appTheme.text3Xl),
                linesNormal(appTheme.text4Xl),
                linesNormal(appTheme.text5Xl),
                linesNormal(appTheme.text6Xl),
                linesNormal(appTheme.text7Xl),
                linesNormal(appTheme.text8Xl),
                linesNormal(appTheme.text9Xl),
              ],
            ),
          ),
          Flexible(
            child: Column(
              children: [
                const Text("Wind Ui"),
                lines(appTheme.textXs),
                lines(appTheme.textSm),
                lines(appTheme.textBase),
                lines(appTheme.textLg),
                lines(appTheme.textXl),
                lines(appTheme.text2Xl),
                lines(appTheme.text3Xl),
                lines(appTheme.text4Xl),
                lines(appTheme.text5Xl),
                lines(appTheme.text6Xl),
                lines(appTheme.text7Xl),
                lines(appTheme.text8Xl),
                lines(appTheme.text9Xl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget linesNormal(FontSize font) {
    return lines(FontSize(fontSize: font.fontSize));
  }

  Widget lines(FontSize font) {
    return Column(
      children: [
        Text("Font Size: ${font.fontSize}\nLine Height:${font.height}"),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer metus nibh, euismod non tempor quis, vulputate eu metus. Phasellus vitae dolor dignissim, pharetra eros at, varius magna. Sed eu hendrerit ipsum. Pellentesque sed fermentum diam, nec ullamcorper sapien. Pellentesque et sapien egestas, scelerisque leo id, tincidunt justo. Nunc in interdum lacus. Nullam in neque eget urna finibus consequat nec et erat.\nDonec sit amet scelerisque est. Suspendisse tempus interdum tincidunt. Praesent sit amet nulla eget felis accumsan lacinia. Morbi iaculis justo ipsum, in fringilla est pharetra sed. Donec ut efficitur risus. Donec fringilla, leo nec ultrices viverra, mi lectus feugiat ex, a ultrices nunc tortor in elit. Quisque elementum odio at nulla molestie semper. Maecenas orci nisl, convallis quis pellentesque sed, lobortis id massa. Proin dignissim arcu enim, non gravida lectus hendrerit a.",
          style: font,
        ),
      ],
    );
  }
}
