import 'package:flutter/material.dart';
import 'package:iron_will/model/rank.dart';

class RankListElement extends StatelessWidget {
  const RankListElement({
    Key? key,
    required this.rank,
    required this.colour,
  }) : super(key: key);

  final Rank rank;
  final bool colour;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          rank.name,
          textAlign: TextAlign.center,
          style:  TextStyle(
            fontWeight: FontWeight.bold,
            color: colour?Theme.of(context).colorScheme.secondaryVariant:Theme.of(context).colorScheme.onSurface
          ),
        ),
        subtitle: Text("Reach ${rank.days} ${rank.days == 1 ? "day" : "days"}",
            textAlign: TextAlign.center),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(color:colour?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.surface, width: 2.0),
          borderRadius: BorderRadius.circular(15.0)),
    );
  }
}
