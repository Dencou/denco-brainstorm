import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/comments_entity.dart';
import '../../domain/entities/ideas_entity.dart';
import '../../domain/repositories/ideas_repository.dart';
import '../datasources/ideas_datasource.dart';
import '../models/comment_model.dart';
import '../models/ideas_model.dart';

@LazySingleton(as: IdeasRepository)
class IdeasRepositoryImpl implements IdeasRepository {
  final IdeasLocalDataSource dataSource;

  IdeasRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<IdeaEntity>>> getIdeas() async {
    try {
      final result = await dataSource.getIdeas();
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(message: 'Error al cargar ideas'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addIdea(IdeaEntity idea) async {
    try {
      final model = IdeaModel.fromEntity(idea);
      await dataSource.addIdea(model);
      return const Right(unit);
    } catch (e) {
      return const Left(CacheFailure(message: 'Error al guardar idea'));
    }
  }

  @override
  Future<Either<Failure, IdeaEntity>> voteIdea(String id) async {
    try {
      final result = await dataSource.voteIdea(id);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(message: 'Error al votar'));
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(String ideaId) async {
    try {
      final result = await dataSource.getComments(ideaId);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(message: 'Error al cargar comentarios'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addComment(String ideaId, CommentEntity comment) async {
    try {
      final model = CommentModel.fromEntity(comment);
      await dataSource.addComment(ideaId, model);
      return const Right(unit);
    } catch (e) {
      return const Left(CacheFailure(message: 'Error al comentar'));
    }
  }
}