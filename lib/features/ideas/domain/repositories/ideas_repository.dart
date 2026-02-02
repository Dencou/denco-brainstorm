import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/comments_entity.dart';
import '../entities/ideas_entity.dart';

abstract class IdeasRepository {
  Future<Either<Failure, List<IdeaEntity>>> getIdeas();

  Future<Either<Failure, Unit>> addIdea(IdeaEntity idea);

  Future<Either<Failure, IdeaEntity>> voteIdea(String id);
  
  Future<Either<Failure, List<CommentEntity>>> getComments(String ideaId);
  
  Future<Either<Failure, Unit>> addComment(String ideaId, CommentEntity comment);
}