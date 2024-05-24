import 'package:creche/core/storage/info_storage.dart';

class AppApi {
  //static const String baseUrl = "http://192.168.1.6:3000/";
  static const String baseUrl = "http://localhost:3000/";

  static const String signUpUrl = "${baseUrl}users/";
  static const String allParentsUrl = "${baseUrl}users/role";
  static const String parentByNameUrl = "${baseUrl}users/userName";

  static const String loginUrl = "${baseUrl}auth/signin";
  static const String logOutUrl = "${baseUrl}auth/logout";

  static const String resetPasswordUrl = "${baseUrl}auth/resetpassword";
  static const String listEnfantsUrl = "${baseUrl}children/";

  static const String categoriesUrl = "${baseUrl}categories/";
  static const String categoriesByIdUrl = "${baseUrl}categories/byid/";

  static const String activitiesUrl = "${baseUrl}activities/";
  static const String imageActivitieUrl = "${baseUrl}file/activities/";
  static const String getUserUrl = "${baseUrl}users/";
  static const String personnelUrl = "${baseUrl}personels/";
  static const String peresonceUrl = "${baseUrl}presences/";
  static const String imageChildrenUrl = "${baseUrl}file/children/";
  static const String situationsUrl = "${baseUrl}situations/";

  static const String listEnfantsByParentUrl = "${baseUrl}children/find/";

  static const String listPresencesByChildUrl = "${baseUrl}presences/find/";
  static String listMessagesUrl = "${baseUrl}messages/";
}
