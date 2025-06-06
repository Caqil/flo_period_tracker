import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/period_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class PredictNextPeriodUsecase implements UseCase<DateTime, NoParams> {
  final PeriodRepository _repository;

  PredictNextPeriodUsecase(this._repository);

  @override
  Future<Either<Failure, DateTime>> call(NoParams params) async {
    return await _repository.predictNextPeriod();
  }
}
