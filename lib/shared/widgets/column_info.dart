import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final String texto;
  const TextLabel({Key? key, required this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

class InfoColumn extends StatelessWidget {
  final String label;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;
  final double font;

  const InfoColumn({
    super.key,
    required this.label,
    required this.value,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.font = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        label.isNotEmpty
            ? TextLabel(texto: label)
            : const SizedBox(
                height: 0,
              ),
        value.isNotEmpty
            ? Text(
                value,
                style: TextStyle(fontSize: font, fontWeight: FontWeight.w100),
              )
            : const SizedBox(
                height: 0,
              ),
      ],
    );
  }
}
