import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


class MyConvert {
  static dynamic jsonParse(List<int> codeUnits) {
    return json.decode(utf8.decode(codeUnits));
  }

  static dynamic jsonParseString(String jsonString) {
    return json.decode(jsonString);
  }

  static String formatMoney(double value) {
    if (value == null) {
      return null;
    }
    return NumberFormat.currency(locale: "eu", symbol: "").format(value);
  }

  static String formatMoneyCurrency(double value) {
    if (value == null) {
      return null;
    }
    return NumberFormat.currency(locale: "eu", symbol: "€").format(value);
  }

  static DateTime parseDate(String date) {
    try {
      if (date == null) {
        return null;
      }
      return DateTime.parse(date);
    } catch (e) {
      return null;
    }
  }

  static String formatDate(DateTime date) {
    return formatDatePattern(date, "dd/MM/yyyy");
  }

  static String formatDatePattern(DateTime date, String pattern) {
    if (date == null) {
      return "";
    }
   String languageCode = Intl.getCurrentLocale();
    return formatDatePatternLanguage(date,pattern,languageCode);
  }

  static String formatDatePatternLanguage(DateTime date, String pattern, languageCode) {
    if (date == null) {
      return "";
    }
    return DateFormat(pattern, languageCode).format(date);
  }

  static String formatString(String value) {
    if (value == null) {
      return "";
    }
    return value;
  }

  static String formatDoubleCastInt(double value) {
    if (value == null) {
      return "";
    }
    return value.toInt().toString();
  }

  static bool isDouble(String value) {
    if (value == null) {
      return true;
    }
    value = value.replaceAll(".", "");
    final n = double.tryParse(value);
    return n != null;
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Uint8List stringToImageMemory(String base64String) {
    return base64Decode(base64String);
  }

  static String stringToCamelCase(String value) {
    String newValue = "";
    if (value != null) {
      List<String> valueList = value.split(" ");
      for (String itemValue in valueList) {
        itemValue = itemValue.substring(0, 1).toUpperCase() + (itemValue.substring(1).toLowerCase());
        newValue = newValue + itemValue + " ";
      }
    }
    return newValue;
  }


  static int parseInt(String value, int nullValue) {
    if(value == null || value.isEmpty){
      return nullValue;
    }
    return int.parse(value);
  }

  static double parseDouble(String value, double nullValue) {
    if(value == null || value.isEmpty){
      return nullValue;
    }
    return double.parse(value);
  }

}
