import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/services/SuperService.dart';

class StudentService implements SuperService<Student, String> {
  @override
  Future<Student> create(Student t) {
    return null;
  }

  @override
  Stream<QuerySnapshot> getAll() {
    return null;
  }

  @override
  Student getByID(String id) {
    return null;
  }

  @override
  Future remove(String id) {
    return null;
  }

  @override
  Future update(Student t) {
    return null;
  }
}
