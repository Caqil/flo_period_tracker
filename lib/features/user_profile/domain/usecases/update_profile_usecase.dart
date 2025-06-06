import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/user_profile.dart';
import '../repositories/user_profile_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class UpdateProfileUsecase implements UseCase<UserProfile, UserProfile> {
  final UserProfileRepository _repository;

  UpdateProfileUsecase(this._repository);

  @override
  Future<Either<Failure, UserProfile>> call(UserProfile profile) async {
    final updatedProfile = profile.copyWith(updatedAt: DateTime.now());
    return await _repository.updateProfile(updatedProfile);
  }
}
