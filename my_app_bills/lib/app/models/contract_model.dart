import 'package:myAppBills/app/models/address_model.dart';
import 'package:myAppBills/utils/convert.dart';

class ContractModel {
   String accountNumber;
   String cil;
   String clientName;
   String clientNumber;
   AddressModel address;
  //detail
   String contractNumber;
   String identificationCode;
   String productCode;
   DateTime startDate;
   String tariffCode;

  ContractModel({this.accountNumber, this.cil, this.clientName, this.clientNumber, this.address,this.productCode,this.startDate,this.contractNumber,
    this.identificationCode,this.tariffCode});

  factory ContractModel.fromJson(Map<String, dynamic> json) {

    //TODO verificar, a API está a retornar uma data com formato invalido. 03-01-1901 00:00:00
    DateTime formatStartDate(String startDate){
        if(startDate == null) {
          return null;
        }
        DateTime startDateParse =  MyConvert.parseDate(startDate);
        if(startDateParse == null){
          String dateWithT = startDate.substring(6,10)+startDate.substring(3, 5)+startDate.substring(0, 2);
          return DateTime.parse(dateWithT);
        }
        return startDateParse;
    }

    return ContractModel(
      accountNumber: json['accountNumber'],
      cil: json['cil'],
      clientName: json['clientName'],
      clientNumber: json['clientNumber'],
      address: AddressModel.fromJson(json['address']),
        contractNumber: json['contractNumber'],
        identificationCode: json['identificationCode'],
        productCode: json['productCode'],
        startDate: formatStartDate(json['startDate']),
        tariffCode: json['tarifCode']
    );

  }


}
