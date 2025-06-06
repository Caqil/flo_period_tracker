import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/cycle.dart';
import '../repositories/period_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class GetCurrentCycleUsecase implements UseCase<Cycle?, NoParams> {
  final PeriodRepository _repository;

  GetCurrentCycleUsecase(this._repository);

  @override
  Future<Either<Failure, Cycle?>> call(NoParams params) async {
    return await _repository.getCurrentCycle();
  }
}
