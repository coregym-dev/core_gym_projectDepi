part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

// حالة التحميل (الـ Loading Shimmer أو الـ Indicator يشتغل هنا)
class ProfileLoading extends ProfileState {}

// حالة نجاح جلب البيانات
class ProfileSuccess extends ProfileState {
  final ProfileUser? profile;
  ProfileSuccess({required this.profile});
}

class ProfileUpdateSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
