import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SuperService<T, ID> {
  Future<T> create(T t);

  Future<dynamic> update(T t);

  Future<dynamic> delete(ID id);

  T getByID(ID id);

  Stream<QuerySnapshot> getAll({int offset, int limit});
}
