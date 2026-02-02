import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/ideas_entity.dart';
import '../repositories/ideas_repository.dart';

@lazySingleton
class VoteIdea implements UseCase<IdeaEntity, String> {
  final IdeasRepository repository;

  VoteIdea(this.repository);

  @override
  Future<Either<Failure, IdeaEntity>> call(String params) async {
    return await repository.voteIdea(params);
  }
}