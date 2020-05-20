import 'package:myAppBills/app/models/address_model.dart';
import 'package:myAppBills/app/models/contract_model.dart';

class ContractDetailModel {

  final AddressModel address;
  final ContractDetailClientModel client;
  final ContractModel contract;
  final bool directDebit;
  final bool electronicInvoice;
  final bool socialTariff;
  final bool gdprMarketing;
  final bool gdprThirdParty;

  ContractDetailModel({this.client, this.address, this.contract, this.directDebit, this.electronicInvoice, this.socialTariff, this.gdprMarketing, this.gdprThirdParty});

  factory ContractDetailModel.fromJson(Map<String, dynamic> json) {

    ContractModel jsonContractModelList(Map<String, dynamic> json){
      List data = json['contracts'].map((model) => ContractModel.fromJson(model)).toList();
      if(data != null && data.isNotEmpty){
        return List.castFrom<dynamic, ContractModel>(data).first;
      }
      return null;
    }

    return ContractDetailModel(
      address: AddressModel.fromJson(json['address']),
      client: ContractDetailClientModel.fromJson(json['client']),
      contract: jsonContractModelList(json),
      directDebit: json['directDebit'] == "true",
      electronicInvoice: json['electronicInvoice'] == "true",
      socialTariff: json['socialTarif'] == "true",
      gdprMarketing: json['gdprMarketing'],
      gdprThirdParty: json['gdprThirdParty']
    );
  }
}

class ContractDetailClientModel {
  final AddressModel address;
  final String name;
  final String nif;
  final String email;
  final String phone;

  ContractDetailClientModel({this.address, this.name, this.nif, this.email, this.phone});

  factory ContractDetailClientModel.fromJson(Map<String, dynamic> json) {
    return ContractDetailClientModel(
      name: json['name'],
      nif: json['nif'],
      phone: json['phone'],
      email: json['email'],
      address: AddressModel.fromJson(json['address']),
    );
  }

}

