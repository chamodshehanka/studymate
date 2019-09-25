import 'package:cloud_functions/cloud_functions.dart';
import 'package:studymate/utils/CommonConstants.dart';

class CloudFunctionService {
  Future<String> addAdmin(String email, String password) async {
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: CommonConstants.addAdminFunction);

    HttpsCallableResult result = await callable.call(email);

    print('Result data auth : ' + result.data);
    return result.data;
  }
}
