import 'package:flutter/material.dart';
import 'package:wind_ui/wind_ui.dart';

final appTheme = AppTheme();

class AppTheme extends FullTheme {
  @override
  Color2 get textSelection => Color2.material(Colors.blue);
  @override
  Color2 get textSelectionCursor => Color2.material(Colors.blueGrey);

  // @override
  // Color2 get action => throw UnimplementedError();

  // @override
  // Color2 get destructive => throw UnimplementedError();

  // @override
  // Color2 get focalPoint => throw UnimplementedError();

  // @override
  // Color2 get positive => throw UnimplementedError();

  @override
  Color2 get primary => Color2.material(Colors.amber);

  @override
  Color2 get secondary => Color2.material(Colors.orange);

  @override
  Color2 get surface => Color2.color(Colors.white);

  // @override
  // Color2 get warning => throw UnimplementedError();
}

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
        backgroundColor: appTheme.primary,
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
                  style: appTheme.text2Xl,
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
                  case 2:
                    body = const Color2Test();
                    _currentIndex = 2;
                  default:
                    body = null;
                    _currentIndex = 0;
                }
              }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.text_format), label: "Text Test"),
            BottomNavigationBarItem(icon: Icon(Icons.colorize), label: "Color2 Test")
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
            child: SelectableRegion(
              focusNode: FocusNode(),
              selectionControls: MaterialTextSelectionControls(),
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
          ),
          Flexible(
            child: SelectableRegion(
              focusNode: FocusNode(),
              selectionControls: MaterialTextSelectionControls(),
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

class Color2Test extends StatelessWidget {
  const Color2Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            test(Colors2.greyNeutral, "Grey Neutral"),
            test(Colors2.greyCool, "Grey Cool"),
            test(Colors2.greyWarm, "Grey Warm"),
            test(Colors2.greyScale, "Grey Scale"),
            test(
                Color2.greyScale(
                    startLightness: 1,
                    endLightness: 0,
                    lightnessCurve: Curves.easeInOutCubic,
                    saturationCurve: Curves.easeInOutCubic),
                "Grey Scale Parabolic Curve"),
            test(
                Color2.greyScale(
                    startLightness: 1,
                    endLightness: 0,
                    lightnessCurve: Curves.slowMiddle,
                    saturationCurve: Curves.slowMiddle),
                "Grey Scale Slow Middle Curve"),
            test(Colors2.greyScaleDark, "Grey Scale Dark"),
            test(Colors2.greyScaleLight, "Grey Scale Light"),
            test(Color2.material(Colors.red), "A material color"),
            test(
                Color2.implicit(
                  shade100:
                      HSLColor.fromColor(Colors.purple).withSaturation(0.1).withLightness(0.7),
                  shade500: HSLColor.fromColor(Colors.purple).withSaturation(1),
                  shade900:
                      HSLColor.fromColor(Colors.purple).withSaturation(0.1).withLightness(0.3),
                ),
                "Implicit: A lot of saturation in middle"),
            test(
                Color2.implicit(
                    shade100: HSLColor.fromColor(Colors.blue),
                    shade900: HSLColor.fromColor(Colors.orange)),
                "Implicit: Two very different colors - blue to orange"),
            test(
                Color2.implicit(
                    shade100: HSLColor.fromColor(Colors.blue),
                    shade700: HSLColor.fromColor(Colors.purple),
                    shade900: HSLColor.fromColor(Colors.orange)),
                "Implicit: Three very different colors - blue 100 to purple 700 to orange 900"),
            test(
                Color2.shade(
                    hue: 189,
                    lightestShade: const SL(saturation: 1, lightness: 0.61),
                    darkestShade: const SL(saturation: 0.64, lightness: 0.12)),
                "Shade: Same type of teal"),
            test(Color2.fullLightScale(57), "Yellow full lightness scale"),
            test(Color2.fullSaturationScale(57), "Yellow full saturation scale"),
            test(
                Color2.implicit(
                    shade100: const HSLColor.fromAHSL(1, 30, 1, 0.5),
                    shade900: const HSLColor.fromAHSL(1, 30, 1, 0.5).decreaseBrightness(1)),
                "Hue Rotation - Brightness Decrease"),
            test(
                Color2.implicit(
                    shade100: const HSLColor.fromAHSL(1, 30, 1, 0.5),
                    shade900: const HSLColor.fromAHSL(1, 30, 1, 0.5).increaseBrightness(1)),
                "Hue Rotation - Brightness Increase"),
          ],
        ),
      ),
    );
  }

  Widget test(Color2 color, String label) {
    return TestColor2(
      color: color,
      label: label,
    );
  }
}
