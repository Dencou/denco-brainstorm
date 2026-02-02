import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/ideas_entity.dart';
import '../repositories/ideas_repository.dart';

@lazySingleton
class AddIdea implements UseCase<Unit, IdeaEntity> {
  final IdeasRepository repository;

  AddIdea(this.repository);

  @override
  Future<Either<Failure, Unit>> call(IdeaEntity params) async {
    return await repository.addIdea(params);
  }
}