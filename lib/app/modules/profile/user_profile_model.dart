import 'package:get/get.dart';

class UserProfile {
  late RxString? firstName;
  late RxString? lastName;
  late RxString? email;
  late RxString? primaryAddress;
  late RxString? secundaryAddress;
  late RxString? locationCode;
  late RxString? locationDescription;
  late RxBool? suscribed;

  UserProfile({
    this.firstName,
    this.lastName,
    this.email,
    this.primaryAddress,
    this.secundaryAddress,
    this.locationCode,
    this.locationDescription,
    this.suscribed,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    firstName!.value = json['firstName'] as String;
    lastName!.value = json['lastName'] as String;
    email!.value = json['email'] as String;

    primaryAddress!.value = json['primaryAddress'] as String;

    secundaryAddress!.value = json['secundaryAddress'] as String;

    locationCode!.value = json['locationCode'] as String;
    locationDescription!.value = json['locationDescription'] as String;
    suscribed!.value = json['suscribed'] as bool;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['firstName'] = firstName!.value;
    data['lastName'] = lastName!.value;
    data['email'] = email!.value;
    data['primaryAddress'] = primaryAddress!.value;
    data['secundaryAddress'] = secundaryAddress!.value;
    data['locationCode'] = locationCode!.value;
    data['locationDescription'] = locationDescription!.value;
    data['suscribed'] = suscribed!.value;
    return data;
  }
}
