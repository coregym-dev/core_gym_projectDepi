part of 'get_sessions_cubit.dart';

@immutable
sealed class GetSessionsState {}

final class GetSessionsInitial extends GetSessionsState {}

// ⏳ حالة التحميل
final class GetSessionsLoading extends GetSessionsState {}

// ✅ حالة نجاح رجوع البيانات ومحملة بـ لستة من الموديل بتاعك
final class GetSessionsSuccess extends GetSessionsState {
  final List<SessionModel> sessions;

  GetSessionsSuccess({required this.sessions});
}

// ❌ حالة حدوث خطأ
final class GetSessionsError extends GetSessionsState {
  final String errorMessage;

  GetSessionsError({required this.errorMessage});
}
