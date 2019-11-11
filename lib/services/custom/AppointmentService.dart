import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Appointment.dart';
import 'package:studymate/utils/CommonConstants.dart';

final CollectionReference appointmentCollection =
    Firestore.instance.collection(CommonConstants.appointmentCollectionName);

class AppointmentService {
  Future<Appointment> createAppointment(Appointment appointment) {
    Appointment appointmentData = appointment;

    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(appointmentCollection.document());

      final Appointment appointment = new Appointment(
          ds.documentID,
          appointmentData.description,
          appointmentData.date,
          appointmentData.time,
          appointmentData.place,
          appointmentData.doctorName,
          appointmentData.studentName,
          appointmentData.isApproved);

      final Map<String, dynamic> data = appointment.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Appointment.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  /// Get All Appointments
  Stream<QuerySnapshot> getAppointmentList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = appointmentCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  /// Get Not Approved Appointments
  Stream<QuerySnapshot> getNotApprovedAppointments({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots =
        appointmentCollection.where('isApproved', isEqualTo: false).snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  /// Get Approved Appointments
  Stream<QuerySnapshot> getApprovedAppointments({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots =
        appointmentCollection.where('isApproved', isEqualTo: true).snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> updateAppointment(Appointment appointment) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(appointmentCollection.document(appointment.id));
      log('App ID : '+appointment.isApproved.toString());
      print('DS : ' + appointment.toMap().toString());
      await tx.update(ds.reference, appointment.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteAppointment(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(appointmentCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}
