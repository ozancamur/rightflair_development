import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rightflair/core/constants/collection.dart';

import '../base/base_modeld.dart';

class FirebaseFirestoreManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // CREATE WITH ID
  Future<void> createWithId({
    required CollectionEnum collection,
    required String id,
    required BaseModel data,
  }) async {
    try {
      await _firestore.collection(collection.path).doc(id).set(data.toJson());
    } catch (e) {
      throw Exception('Döküman oluşturulurken hata: $e');
    }
  }

  // CREATE
  Future<String> create({
    required CollectionEnum collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      final docRef = await _firestore.collection(collection.path).add(data);
      return docRef.id;
    } catch (e) {
      throw Exception('Döküman oluşturulurken hata: $e');
    }
  }

  // READ
  Future<Map<String, dynamic>?> getDocument({
    required CollectionEnum collection,
    required String docId,
  }) async {
    try {
      final doc = await _firestore.collection(collection.path).doc(docId).get();
      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      throw Exception('Döküman okunurken hata: $e');
    }
  }

  // READ - Koleksiyondaki tüm dökümanları oku
  Future<List<Map<String, dynamic>>> getAllDocuments({
    required String collection,
  }) async {
    try {
      final querySnapshot = await _firestore.collection(collection).get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();
    } catch (e) {
      throw Exception('Dökümanlar okunurken hata: $e');
    }
  }

  // READ - Sorgu ile dökümanları oku
  Future<List<Map<String, dynamic>>> queryDocuments({
    required String collection,
    required String field,
    required dynamic value,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(collection)
          .where(field, isEqualTo: value)
          .get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();
    } catch (e) {
      throw Exception('Sorgu yapılırken hata: $e');
    }
  }

  // UPDATE - Dökümanı güncelle
  Future<void> updateDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
    } catch (e) {
      throw Exception('Döküman güncellenirken hata: $e');
    }
  }

  // UPDATE - Dökümanı oluştur veya güncelle (merge)
  Future<void> setDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
    bool merge = true,
  }) async {
    try {
      await _firestore
          .collection(collection)
          .doc(docId)
          .set(data, SetOptions(merge: merge));
    } catch (e) {
      throw Exception('Döküman ayarlanırken hata: $e');
    }
  }

  // DELETE - Döküman sil
  Future<void> deleteDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
    } catch (e) {
      throw Exception('Döküman silinirken hata: $e');
    }
  }

  // USERS koleksiyonu için özel fonksiyonlar

  // Kullanıcı var mı kontrolü
  Future<bool> userExists(String userId) async {
    try {
      final doc = await _firestore
          .collection(CollectionEnum.USERS.path)
          .doc(userId)
          .get();
      return doc.exists;
    } catch (e) {
      throw Exception('Kullanıcı kontrol edilirken hata: $e');
    }
  }

  Future<bool> isUserExists(String uid) async {
    try {
      final doc = await _firestore
          .collection(CollectionEnum.USERS.path)
          .doc(uid)
          .get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  // Kullanıcının username'i null mı kontrolü
  Future<bool> isUsernameNull(String userId) async {
    try {
      final doc = await _firestore
          .collection(CollectionEnum.USERS.path)
          .doc(userId)
          .get();

      if (!doc.exists) return true;

      final data = doc.data();
      return data?['username'] == null;
    } catch (e) {
      return true;
    }
  }

  Future<bool> isUsernameUnique(String username) async {
    try {
      final data = await _firestore
          .collection(CollectionEnum.USERSNAMES.path)
          .doc(username)
          .get();
      return !data.exists;
    } catch (e) {
      return false;
    }
  }

  // Username'i kaydet (hem users hem usernames koleksiyonuna)
  Future<void> saveUsername({
    required String uid,
    required String username,
  }) async {
    try {
      // Users koleksiyonunda username'i güncelle
      await _firestore.collection(CollectionEnum.USERS.path).doc(uid).update({
        'username': username,
      });

      // Usernames koleksiyonuna kaydet
      await _firestore
          .collection(CollectionEnum.USERSNAMES.path)
          .doc(username)
          .set({'uid': uid});
    } catch (e) {
      throw Exception('Username kaydedilirken hata: $e');
    }
  }

  // Stream ile gerçek zamanlı veri dinle
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamDocument({
    required CollectionEnum collection,
    required String docId,
  }) {
    return _firestore.collection(collection.path).doc(docId).snapshots();
  }

  // Stream ile koleksiyon dinle
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection({
    required CollectionEnum collection,
  }) {
    return _firestore.collection(collection.path).snapshots();
  }
}
