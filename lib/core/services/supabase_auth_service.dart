// import 'dart:developer';
// import 'package:fannyk/core/errors/exceptions.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class SupabaseAuthService {
//   final SupabaseClient _supabase = Supabase.instance.client;

//   Future<User> createUserWithEmailAndPassword({
//     required String email,
//     required String password,
//     required String role,
//   }) async {
//     try {
//       final response = await _supabase.auth.signUp(
//         email: email,
//         password: password,
//         data: {'role': role},
//       );
//       if (response.user == null) {
//         throw CustomException(message: 'لم يتم إنشاء المستخدم.');
//       }
//       return response.user!;
//     } on AuthException catch (e) {
//       log(
//         "SupabaseAuthService.createUserWithEmailAndPassword error: ${e.message}",
//       );
//       throw CustomException(message: e.message);
//     } catch (e) {
//       log("SupabaseAuthService.createUserWithEmailAndPassword error: $e");
//       throw CustomException(message: 'حدث خطأ أثناء إنشاء الحساب.');
//     }
//   }

//   Future<User> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final response = await _supabase.auth.signInWithPassword(
//         email: email,
//         password: password,
//       );
//       if (response.user == null) {
//         throw CustomException(message: 'فشل تسجيل الدخول.');
//       }
//       return response.user!;
//     } on AuthException catch (e) {
//       log("SupabaseAuthService.signInWithEmailAndPassword error: ${e.message}");
//       throw CustomException(message: e.message);
//     } catch (e) {
//       log("SupabaseAuthService.signInWithEmailAndPassword error: $e");
//       throw CustomException(message: 'حدث خطأ أثناء تسجيل الدخول.');
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       await _supabase.auth.signOut();
//     } on AuthException catch (e) {
//       log("SupabaseAuthService.signOut error: ${e.message}");
//       throw CustomException(message: e.message);
//     } catch (e) {
//       log("SupabaseAuthService.signOut error: $e");
//       throw CustomException(message: 'حدث خطأ أثناء تسجيل الخروج.');
//     }
//   }

//   Future<void> deleteUser() async {
//     try {
//       final userId = _supabase.auth.currentUser?.id;
//       if (userId == null) {
//         throw CustomException(message: 'لا يوجد مستخدم حالياً.');
//       }
//       await _supabase.rpc('delete_user', params: {'uid': userId});
//       await signOut();
//     } catch (e) {
//       log("SupabaseAuthService.deleteUser error: $e");
//       throw CustomException(message: 'حدث خطأ أثناء حذف الحساب.');
//     }
//   }

//   bool isLoggedIn() {
//     return _supabase.auth.currentUser != null;
//   }

//   Session? getCurrentSession() {
//     return _supabase.auth.currentSession;
//   }

//   User? getCurrentUser() {
//     return _supabase.auth.currentUser;
//   }
// }
