import 'package:cloud_functions/cloud_functions.dart';
import 'package:studymate/utils/CommonConstants.dart';

class CloudFunctionService {
  Future<String> addAdmin(String email, String password) async {
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: CommonConstants.addAdminFunction);

    Map<String, Object> data = new Map();
    data['email'] = email;
    data['password'] = password;

    print(data);

    HttpsCallableResult result = await callable.call(data);

    print('Result data auth : ' + result.data);
    return result.data;
  }
}
