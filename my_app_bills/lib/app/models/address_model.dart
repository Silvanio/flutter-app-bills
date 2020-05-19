import 'package:myutility/utils/convert.dart';

class AddressModel {

  final String city;
  final String cp3;
  final String cp4;
  final String district;
  final String floor;
  final String local;
  final String parish;
  final String port;
  final String street;

  String getCompleteAddress(){
    return street + " "+ port + " - "+ city;
  }

  String getStreetComplete(){
    return  street + " "+ port;
  }

  String getCepComplete(){
    return cp4 +"-"+cp3 + " "+ city;
  }

  AddressModel({this.city, this.cp3, this.cp4, this.district, this.floor, this.local, this.parish, this.port, this.street});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: MyConvert.formatString(json['city']) ,
      cp3: MyConvert.formatString(json['cp3']),
      cp4:MyConvert.formatString(json['cp4']),
      district:MyConvert.formatString(json['district']),
      floor: MyConvert.formatString(json['floor']),
      local: MyConvert.formatString(json['local']),
      parish: MyConvert.formatString(json['parish']),
      port: MyConvert.formatString(json['port']),
      street: MyConvert.formatString(json['street']),
    );
  }
}
