import 'package:flutter/cupertino.dart';

class TypeContract {
  static const WATER = const AssetImage("assets/images/ic_contract_ag.png");
  static const GAS = const AssetImage("assets/images/ic_contract_gp.png");
  static const ELECTRICITY = const AssetImage("assets/images/ic_contract_ag.png");

  static get values => [WATER, GAS, ELECTRICITY];

  static AssetImage getImage(String value) {
    switch (value) {
      case "AG":
        {
          return WATER;
        }
      case "GP":
        {
          return GAS;
        }
      case "EB":
        {
          return ELECTRICITY;
        }
      case "EM":
        {
          return ELECTRICITY;
        }
    }
    return WATER;
  }

  final int value;

  const TypeContract._(this.value);
}
