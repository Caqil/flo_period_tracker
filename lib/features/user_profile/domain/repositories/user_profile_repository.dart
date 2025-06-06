import 'package:dartz/dartz.dart';
import '../entities/user_profile.dart';
import '../../../../core/error/failures.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserProfile?>> getCurrentProfile();
  Future<Either<Failure, UserProfile>> createProfile(UserProfile profile);
  Future<Either<Failure, UserProfile>> updateProfile(UserProfile profile);
  Future<Either<Failure, void>> deleteProfile();
  Future<Either<Failure, bool>> verifyPin(String pin);
  Future<Either<Failure, bool>> verifyBiometric();
  Future<Either<Failure, void>> setPin(String pin);
}
