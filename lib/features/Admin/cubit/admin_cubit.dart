import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  AdminCubit() : super(AdminInitial());

  // --- Users ---

  Future<void> fetchUsers() async {
    emit(AdminLoading());
    try {
      final querySnapshot = await _firestore.collection('users').get();
      final users = querySnapshot.docs
          .map((doc) => {
                'uid': doc.id,
                'name': doc.data()['firstName'] ?? '',
                'email': doc.data()['email'] ?? '',
              })
          .toList();
      emit(AdminUsersLoaded(users));
    } catch (e) {
      emit(AdminError('Failed to fetch users: $e'));
    }
  }

  Future<void> deleteUser(String uid) async {
    emit(AdminLoading());
    try {
      await _firestore.collection('users').doc(uid).delete();
      emit(const AdminActionSuccess('User deleted successfully'));
      await fetchUsers(); // Refresh list
    } catch (e) {
      emit(AdminError('Failed to delete user: $e'));
    }
  }

  // --- Plans ---

  Future<void> addOrUpdatePlanDocument({
    required String collectionName,
    required String docName,
    required String fieldName,
    required String mapKey,
    required String mapValue,
  }) async {
    emit(AdminLoading());
    try {
      final docRef = _firestore.collection(collectionName).doc(docName);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.update({'$fieldName.$mapKey': mapValue});
      } else {
        await docRef.set({fieldName: {mapKey: mapValue}});
      }

      emit(const AdminActionSuccess('Data added/updated successfully'));
    } catch (e) {
      emit(AdminError('Failed to add/update document: $e'));
    }
  }

  // --- Food (Realtime Database) ---

  Future<void> addFoodToRealtimeDatabase(String key, String value) async {
    emit(AdminLoading());
    try {
      await _database.child(key).set(value);
      emit(const AdminActionSuccess('Food added successfully'));
    } catch (e) {
      emit(AdminError('Failed to add food: $e'));
    }
  }

  Future<void> deleteFoodFromRealtimeDatabase(String key) async {
    emit(AdminLoading());
    try {
      await _database.child(key).remove();
      emit(const AdminActionSuccess('Food deleted successfully'));
    } catch (e) {
      emit(AdminError('Failed to delete food: $e'));
    }
  }
}
