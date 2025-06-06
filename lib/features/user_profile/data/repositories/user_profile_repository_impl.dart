import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../datasources/user_profile_local_datasource.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

@LazySingleton(as: UserProfileRepository)
class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileLocalDatasource _localDatasource;

  UserProfileRepositoryImpl(this._localDatasource);

  @override
  Future<Either<Failure, UserProfile?>> getCurrentProfile() async {
    try {
      final profile = await _localDatasource.getCurrentProfile();
      return Right(profile);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> createProfile(
    UserProfile profile,
  ) async {
    try {
      final result = await _localDatasource.createProfile(profile);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateProfile(
    UserProfile profile,
  ) async {
    try {
      final result = await _localDatasource.updateProfile(profile);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfile() async {
    try {
      await _localDatasource.deleteProfile();
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyPin(String pin) async {
    // TODO: Implement PIN verification
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> verifyBiometric() async {
    // TODO: Implement biometric verification
    return const Right(true);
  }

  @override
  Future<Either<Failure, void>> setPin(String pin) async {
    // TODO: Implement PIN setting
    return const Right(null);
  }
}
