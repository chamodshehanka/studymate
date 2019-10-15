import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:studymate/utils/CommonConstants.dart';

class CloudFunctionService {
  Future<String> addAdmin(String email) async {
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: CommonConstants.addAdminFunction);

    Map<String, dynamic> data = new Map();
    data['email'] = email;

    HttpsCallableResult result = await callable.call(data);

    return result.data.toString();
  }

  Future<String> addDoctor(String email) async {
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: CommonConstants.addDoctorFunction);
    Map<String, dynamic> data = new Map();
    data['email'] = email;

    HttpsCallableResult result = await callable.call(data);
    return result.data.toString();
  }

  Future<String> addStudent(String email) async {
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: CommonConstants.addStudentFunction);

    Map<String, dynamic> data = new Map();
    data['email'] = email;

    HttpsCallableResult result = await callable.call(data);
    return result.data.toString();
  }

  Future<String> sendMessageToParent(String message) async {
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'sendMessageToParent');

    log(CommonConstants.sendMessageToParent);

    Map<String, dynamic> data = new Map();
    data['message'] = message;

    HttpsCallableResult result = await callable.call(data);
    // log('result : ' + result.data.toString());
    return result.data.toString();
  }

  Future<String> cloudNotificationFunction(String authId) async {
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'cloudNotificatinFunction');

    Map<String, dynamic> data = new Map();
    data['authId'] = authId;

    HttpsCallableResult result = await callable.call(data);
    return result.data.toString();
  }
}
