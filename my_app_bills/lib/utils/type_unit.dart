class TypeUnit {
  //WATER
  static const _WATER = "M3";
  static const WATER_ICON = "assets/images/ic_water.png";
  static const WATER_UNIT = "m³";

  //ENERGY - AINDA POR DESENVOLVER
  static const _ENERGY = "??";
  static const ENERGY_ICON = "assets/images/ic_water.png";
  static const ENERGY_UNIT = "??";

  static String getIcon(String unit) {
    return _get(unit, true);
  }

  static String getUnit(String unit) {
    return _get(unit, false);
  }

  static String _get(String unit, bool isIcon) {
    if (unit == null) {
      return isIcon ? WATER_ICON : WATER_UNIT;
    }
    switch (unit.toUpperCase()) {
      case _WATER:
        {
          return isIcon ? WATER_ICON : WATER_UNIT;
        }
      case _ENERGY:
        {
          return isIcon ? ENERGY_ICON : ENERGY_UNIT;
        }
    }
    return isIcon ? WATER_ICON : WATER_UNIT;
  }
}
