import 'package:flutter/material.dart';
import 'package:qr_attend/utils/texts.dart';

class AdminCard extends StatelessWidget {
  final card;
  final params;
  final value;
  final name;

  AdminCard({this.card, this.params, this.value, this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: this.params['width'],
        height: this.params['height'],
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bold16Text(value.toString(), size: 24),
                bold16Text(
                  name,
                ),
              ],
            ),
            Icon(
              IconData(this.card['icon'], fontFamily: 'MaterialIcons'),
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
