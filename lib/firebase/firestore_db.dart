import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milkmatehub/local_storage/key_value_storage_service.dart';
import 'package:milkmatehub/models/feed_model.dart';
import 'package:milkmatehub/models/insurance_model.dart';
import 'package:milkmatehub/models/production_record_model.dart';
import 'package:milkmatehub/models/supplier_model.dart';
import 'package:milkmatehub/models/user_model.dart';

class FirestoreDB {
  final db = FirebaseFirestore.instance;

  Future<void> addFeed(FeedModel feed) async {
    try {
      final data = await db
          .collection('feedCollection')
          .doc(feed.feedId)
          .set(feed.toJson());
      return data;
    } catch (e) {
      throw Exception('Error adding feed: $e');
    }
  }

  Future<void> addInsuranceApplication(InsuranceModel record) async {
    try {
      final data = await db
          .collection('insuranceCollection')
          .doc(record.uid)
          .set(record.toJson());
      return data;
    } catch (e) {
      throw Exception('Error adding insurance record: $e');
    }
  }

  Future<void> addProductionRecord(ProductionRecordModel record) async {
    try {
      final data = await db
          .collection('productionRecordCollection')
          .doc(record.id)
          .set(record.toJson());
      return data;
    } catch (e) {
      throw Exception('Error adding production record: $e');
    }
  }

  Future<void> addSupplier(SupplierModel doc) async {
    try {
      final data = await db
          .collection('supplierCollection')
          .doc(doc.uid)
          .set(doc.toJson());
      return data;
    } catch (e) {
      throw Exception('Error adding supplier: $e');
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      final data = await db
          .collection('userCollection')
          .doc(user.uid)
          .set(user.toJson());
      return data;
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }

  Future<void> deleteFeed(String feedId) async {
    try {
      await db.collection('feedCollection').doc(feedId).delete();
    } catch (e) {
      throw Exception('Error deleting feed: $e');
    }
  }

  Future<void> deleteSupplier(String supplierId) async {
    try {
      await db.collection('supplierCollection').doc(supplierId).delete();
    } catch (e) {
      throw Exception('Error deleting supplier: $e');
    }
  }

  Future<void> editFeed(FeedModel updatedFeed) async {
    try {
      final data = await db
          .collection('feedCollection')
          .doc(updatedFeed.feedId)
          .update(updatedFeed.toJson());
      return data;
    } catch (e) {
      throw Exception('Error editing feed: $e');
    }
  }

  Future<void> editSupplier(SupplierModel updatedSupplier) async {
    try {
      final data = await db
          .collection('supplierCollection')
          .doc(updatedSupplier.uid)
          .update(updatedSupplier.toJson());
      return data;
    } catch (e) {
      throw Exception('Error editing supplier: $e');
    }
  }

  Future<List<ProductionRecordModel>> getAllProductionRecords() async {
    try {
      final snapshot = await db.collection('productionRecordCollection').get();
      return snapshot.docs
          .map((doc) => ProductionRecordModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error getting production records: $e');
    }
  }

  Future<List<SupplierModel>> getAllSuppliers() async {
    try {
      final snapshot = await db.collection('supplierCollection').get();
      return snapshot.docs
          .map((doc) => SupplierModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error getting supplier records: $e');
    }
  }

  Future<List<FeedModel>> getFeedList() async {
    try {
      final snapshot = await db.collection('feedCollection').get();
      return snapshot.docs
          .map((doc) => FeedModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error getting supplier: $e');
    }
  }

  Future<List<InsuranceModel>> getInsuanceClaimList() async {
    try {
      CacheStorageService cacheStorageService = CacheStorageService();
      final user = await cacheStorageService.getAuthUser();
      final snapshot = await db
          .collection('insuranceCollection')
          .where('supplierId', isEqualTo: user!.uid)
          .get();
      return snapshot.docs
          .map((doc) => InsuranceModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error getting insurance claims: $e');
    }
  }

  Future<List<ProductionRecordModel>> getProductionRecords() async {
    try {
      CacheStorageService cacheStorageService = CacheStorageService();
      final user = await cacheStorageService.getAuthUser();
      final snapshot = await db
          .collection('productionRecordCollection')
          .where('supplierId', isEqualTo: user!.uid)
          .get();
      return snapshot.docs
          .map((doc) => ProductionRecordModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error getting production records: $e');
    }
  }

  Future<Map<String, dynamic>?> getSupplier(String uid) async {
    try {
      final snapshot = await db.collection('supplierCollection').doc(uid).get();
      return snapshot.data();
    } catch (e) {
      throw Exception('Error getting supplier: $e');
    }
  }

  Future<Map<String, dynamic>?> getUser(String uid, bool isSupplier) async {
    try {
      final snapshot = await db
          .collection(isSupplier ? 'supplierCollection' : 'userCollection')
          .doc(uid)
          .get();
      return snapshot.data();
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }
}
