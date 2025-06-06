import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/user_profile.dart';
import '../repositories/user_profile_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class GetProfileUsecase implements UseCase<UserProfile?, NoParams> {
  final UserProfileRepository _repository;

  GetProfileUsecase(this._repository);

  @override
  Future<Either<Failure, UserProfile?>> call(NoParams params) async {
    return await _repository.getCurrentProfile();
  }
}
