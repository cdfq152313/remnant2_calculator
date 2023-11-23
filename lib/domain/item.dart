import 'package:remnant2_calculator/domain/effect.dart';

class Item {
  Item({required this.name, required this.effects});

  final String name;
  final List<Effect> effects;
}
