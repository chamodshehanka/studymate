import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/screens/ScheduleScreen/DailyStudy.dart';
import 'package:studymate/services/SuperService.dart';

final CollectionReference subjectsCollection =
    Firestore.instance.collection('subject');

class SubjectService extends SuperService<Subject, String> {
  @override
  Future<Subject> create(Subject subject) {
    return null;
  }

  @override
  Future delete(String id) {
    return null;
  }

  @override
  Stream<QuerySnapshot> getAll({int offset, int limit}) {
    return null;
  }

  @override
  Future update(Subject subject) {
    return null;
  }

  @override
  Future<Subject> getByID(String id) {
    return null;
  }
}