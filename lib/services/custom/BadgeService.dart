import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:studymate/models/Badge.dart';

final CollectionReference badgeCollection =
    Firestore.instance.collection('badges');

class BadgeService {
  Future<Badge> createBadge(
      String name, String type, String task,String milestone, String description, List<Asset> images) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(badgeCollection.document());

      for (Asset image in images) {
        StorageReference firebaseStorage = FirebaseStorage.instance
            .ref()
            .child('badges')
            .child(ds.documentID);

        image.filePath.then(((path) async {
        ImageProperties properties = await FlutterNativeImage.getImageProperties(path);
File compressedFile = await FlutterNativeImage.compressImage(path, quality: 80, 
    targetWidth: 1000, 
    targetHeight: (properties.height * 600 / properties.width).round());
          firebaseStorage.putFile(compressedFile);
        }));
      }

      final Badge badge =
          new Badge(ds.documentID, name, type, task,milestone, description);
      final Map<String, dynamic> data = badge.toMap();

      await tx.set(ds.reference, data);
      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Badge.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getSubjectBadgeList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots =
        badgeCollection.where('type', isEqualTo: 'Subject').snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getActivityBadgeList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots =
        badgeCollection.where('type', isEqualTo: 'Activity').snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getBadgeList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = badgeCollection.snapshots();
    

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> updateBadge(Badge badge) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(badgeCollection.document(badge.id));

      await tx.update(ds.reference, badge.toMap());
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

  Future<dynamic> deleteBadge(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(badgeCollection.document(id));

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
