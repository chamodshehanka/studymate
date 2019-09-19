import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/services/SuperService.dart';

final CollectionReference studentsCollection =
    Firestore.instance.collection('students');

class StudentService implements SuperService<Student, String> {
  @override
  Future<Student> create(Student student) {
    return null;
  }

  @override
  Stream<QuerySnapshot> getAll({int offset, int limit}) {
    return null;
  }

  @override
  Student getByID(String id) {
    return null;
  }

  Future delete(String id) {
    return null;
  }

  @override
  Future update(Student student) {
    return null;
  }

  // get All students preffered Activities
  // Stream<QuerySnapshot> getActivitiesList({int offset, int limit}){
    
  // }
}
