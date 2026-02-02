import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/ideas_entity.dart';
import '../repositories/ideas_repository.dart';

@lazySingleton
class GetIdeas implements UseCase<List<IdeaEntity>, NoParams> {
  final IdeasRepository repository;

  GetIdeas(this.repository);

  @override
  Future<Either<Failure, List<IdeaEntity>>> call(NoParams params) async {
    return await repository.getIdeas();
  }
}