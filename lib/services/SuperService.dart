import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SuperService<T, ID> {
  Future<T> create(T t);
  
  Future<dynamic> update(T t);

  Future<dynamic> remove(ID id);

  T getByID(ID id);

  Stream<QuerySnapshot> getAll();
}