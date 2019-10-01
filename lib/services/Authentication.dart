import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:studymate/services/CloudFunctionsService.dart';
import 'package:studymate/services/custom/AdminServices.dart';
import 'package:studymate/services/custom/DoctorService.dart';
import 'package:studymate/services/custom/StudentService.dart';

abstract class BaseAuthentication {
  Future<FirebaseUser> signIn(String email, String password);
  Future<String> signUp(
      String email, String password, String userType, Object userObject);
  Future<String> getCurrentUser();
  Future<void> signOut();
}

class Authentication implements BaseAuthentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CloudFunctionService _cloudFunctionService = CloudFunctionService();
  AdminService _adminService = AdminService();
  DoctorService _doctorService = DoctorService();
  StudentService _studentService = StudentService();

  @override
  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  @override
  Future<FirebaseUser> signIn(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<String> signUp(
      String email, String password, String userType, Object userObject) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    switch (userType) {
      case 'admin':
        Future<String> customClaimResult =
            _cloudFunctionService.addAdmin(email);
        customClaimResult.then((result) {
          print("Claim result : " + result);
        });
        // Admin creation in collection
        _adminService.create(userObject, user.uid);
        break;
      case 'doctor':
        Future<String> customClaimResult =
            _cloudFunctionService.addDoctor(email);
        customClaimResult.then((result) {
          print("Claim result : " + result);
        });
        // Doctor creation in collection
        _doctorService.create(userObject, user.uid);
        break;
      case 'student':
        Future<String> customClaimResult =
            _cloudFunctionService.addStudent(email);
        customClaimResult.then((result) {
          print("Claim result : " + result);
        });
        // student creation in collection
        _studentService.createStudent(userObject, user.uid);
        break;
      default:
        print('Invalid user type!!');
    }

    return user.uid;
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this email address not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'This email address already has an account.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }
}
