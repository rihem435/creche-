import 'package:creche/core/storage/storage.dart';

class InfoStorage {
  static const keyEmail = "email";
  static const keyName = "fullName";
  static const keyLongitude = "longitude";
  static const keyCatName = "cat";
  static const keyId = "id";
  static const keyIdPersonnel = 'idp';
  static const keyVille = 'ville';
  static const keyStatus = 's';
  static const keyTime = 'time';

  static const keyIdEnfant = "idEn";
  static const keyIdSituation = "situation";

  static const keyIdPresence = "idPre";
  static const keyIdCat = "idcat";
  static const keyIdParent = "idParent";

  static const keyCat = "categoryy";

  static const String keyToken = "token";
  static const keyRole = "role";
  static saveRole(role) {
    SecureStorage.writeSecureData(key: keyRole, value: role);
  }

  static String? readRole() {
    return SecureStorage.readSecureData(keyRole);
  }

  static saveIdSituation(si) {
    SecureStorage.writeSecureData(key: keyIdSituation, value: si);
  }

  static String? readIdSituation() {
    return SecureStorage.readSecureData(keyIdSituation);
  }

  static saveIdParent(parent) {
    SecureStorage.writeSecureData(key: keyIdParent, value: parent);
  }

  static String? readIdParent() {
    return SecureStorage.readSecureData(keyIdParent);
  }

  static String? removeIdParent() {
    SecureStorage.deleteSecureData(keyIdParent);
    return null;
  }

  static saveStatus(String status) {
    SecureStorage.writeSecureData(key: keyStatus, value: status);
  }

  static String? readStatus() {
    return SecureStorage.readSecureData(keyStatus);
  }

  static saveCat(String cat) {
    SecureStorage.writeSecureData(key: keyCat, value: cat);
  }

  static String? readCat() {
    return SecureStorage.readSecureData(keyCat);
  }

  static saveTime(time) {
    SecureStorage.writeSecureData(key: keyTime, value: time);
  }

  static String? readTime() {
    return SecureStorage.readSecureData(keyTime);
  }

  static saveToken(String token) {
    SecureStorage.writeSecureData(key: keyToken, value: token);
  }

  static String? readToken() {
    return SecureStorage.readSecureData(keyToken);
  }

  static saveEmail(email) {
    SecureStorage.writeSecureData(key: keyEmail, value: email);
  }

  static String? readEmail() {
    return SecureStorage.readSecureData(keyEmail);
  }

  static saveFullname(fullName) {
    SecureStorage.writeSecureData(key: keyName, value: fullName);
  }

  static String? readName() {
    return SecureStorage.readSecureData(keyName);
  }

  static saveIdPersonnel(idP) {
    SecureStorage.writeSecureData(key: keyIdPersonnel, value: idP);
  }

  static String? readIpPersonnel() {
    return SecureStorage.readSecureData(keyIdPersonnel);
  }

  static saveIdCategory(idCate) {
    SecureStorage.writeSecureData(key: keyIdCat, value: idCate);
  }

  static String? readIdCategory() {
    return SecureStorage.readSecureData(keyIdCat);
  }

  static saveIdPresence(idPre) {
    SecureStorage.writeSecureData(key: keyIdPresence, value: idPre);
  }

  static String? readIpPresence() {
    return SecureStorage.readSecureData(keyIdPresence);
  }

  static saveCatname(String name) {
    SecureStorage.writeSecureData(key: keyCatName, value: name);
  }

  static String? readCatName() {
    return SecureStorage.readSecureData(keyCatName);
  }

  static saveId(id) {
    SecureStorage.writeSecureData(key: keyId, value: id);
  }

  static String? readId() {
    return SecureStorage.readSecureData(keyId);
  }

  static saveIdEnfants(id) {
    SecureStorage.writeSecureData(key: keyIdEnfant, value: id);
  }

  static String? readIdEnfant() {
    return SecureStorage.readSecureData(keyIdEnfant);
  }

  static removeId() {
    SecureStorage.deleteSecureData(keyId);
  }
}
