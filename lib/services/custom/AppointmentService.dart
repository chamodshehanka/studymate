import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Appointment.dart';
import 'package:studymate/utils/CommonConstants.dart';

//Create Collection and give it Name as "appointment" as appoiintmentCollectionName to CommanConstants
final CollectionReference appointmentCollection =
    Firestore.instance.collection(CommonConstants.appointmentCollectionName);//Utils/CommanConstants

//Create Service Class to DB
class AppointmentService {
//Create method as "createAppointment" to create a appointment
//Type is <Appointment>(Form details)
  Future<Appointment> createAppointment(String specialDescription,String date,String time,String place) {
    //create transactional handler
    final TransactionHandler createTransaction = (Transaction tx) async {
      //Create Document Snapshot get that perticular documents
      final DocumentSnapshot ds = await tx.get(appointmentCollection.document());
      //assigning details previously mentions in that create new appointment form properties
      //***Create instance */passing all the details recieve from my form
      final Appointment appointment = new Appointment(ds.documentID, specialDescription,date,time,place);
      //We are create Map function and we are give it as "data"
      //use to map and send it back to the firestore
      final Map<String, dynamic> data = appointment.toMap();
      //when we wants to set data to refrence
      /**Set our document snapshot with the reference and assign with data */
      await tx.set(ds.reference, data);
      //**all are map to the data */
      //& return data
      return data;
    };
    //Run transaction and Create transaction
    //onece it is done return Appointment from map
    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Appointment.fromMap(mapData);
      //if not catch error
      //retrn null and print error
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  //Get All Appointments
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

  Future<dynamic> updateAppointment(Appointment appointment) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(appointmentCollection.document(appointment.id));

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
      final DocumentSnapshot ds = await tx.get(appointmentCollection.document(id));

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
