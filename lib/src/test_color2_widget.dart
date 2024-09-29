import 'package:flutter/widgets.dart';
import 'package:wind_ui/wind_ui.dart';

/// A widget for testing the look of a [Color2] palet.
class TestColor2 extends StatelessWidget {
  final Color2 color;
  final String? label;

  const TestColor2({super.key, required this.color, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(label!),
        const SizedBox(height: 5),
        Row(
          children: [
            Column(
              children: [
                const Text("50"),
                Container(
                  width: 30,
                  height: 30,
                  color: color.shade50,
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                const Text("100"),
                Container(
                  width: 30,
                  height: 30,
                  color: color.shade100,
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                const Text("200"),
                Container(
                  width: 30,
                  height: 30,
                  color: color.shade200,
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                const Text("300"),
                Container(
                  width: 30,
                  height: 30,
                  color: color.shade300,
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                const Text("400"),
                Container(
                  width: 30,
                  height: 30,
                  color: color.shade400,
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                const Text("500"),
                Container(
                  width: 30,
                  height: 30,
                  color: color.shade500,
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                const Text("600"),
                Container(
                  width: 30,
                  height: 30,
                  color: color.shade600,
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                const Text("700"),
                Container(
                  width: 30,
                  height: 30,
                  color: color.shade700,
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                const Text("800"),
                Container(
                  width: 30,
                  height: 30,
                  color: color.shade800,
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                const Text("900"),
                Container(
                  width: 30,
                  height: 30,
                  color: color.shade900,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
