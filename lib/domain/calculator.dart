import 'package:remnant2_calculator/extension.dart';

class Calculator {
  num base = 1;
  num criticalChance = 0.pc;
  num criticalDamage = 50.pc;

  void setBase(double value) {
    base = value;
  }

  void setCriticalChance(int value) {
    criticalChance = value.pc;
  }

  void setCriticalDamage(int value) {
    criticalDamage = value.pc;
  }

  int calculate() {
    return (base * (1 + criticalChance * criticalDamage)).toInt();
  }
}
