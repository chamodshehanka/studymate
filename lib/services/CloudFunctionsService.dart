import 'package:cloud_functions/cloud_functions.dart';
import 'package:studymate/utils/CommonConstants.dart';

class CloudFunctionService {
  Future<String> addAdmin(String email) async {
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: CommonConstants.addAdminFunction);

    Map<String, dynamic> data = new Map();
    data['email'] = email;

    HttpsCallableResult result = await callable.call(data);

    return result.data;
  }

  Future<String> addDoctor(String email) async {
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: CommonConstants.addDoctorFunction);
    Map<String, dynamic> data = new Map();
    data['email'] = email;

    HttpsCallableResult result = await callable.call(data);
    return result.data;
  }

  Future<String> addStudent(String email) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(functionName: 
    CommonConstants.addStudentFunction);

    Map<String, dynamic> data = new Map();   
    data['email'] = email;

    HttpsCallableResult result = await callable.call(data);
    return result.data;
  }
}
