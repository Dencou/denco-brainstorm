import 'package:injectable/injectable.dart';
import '../../domain/entities/ideas_entity.dart';
import '../models/comment_model.dart';
import '../models/ideas_model.dart';

abstract class IdeasLocalDataSource {
  Future<List<IdeaModel>> getIdeas();
  Future<void> addIdea(IdeaModel idea);
  Future<IdeaModel> voteIdea(String id);
  Future<List<CommentModel>> getComments(String ideaId);
  Future<void> addComment(String ideaId, CommentModel comment);
}

@LazySingleton(as: IdeasLocalDataSource)
class IdeasLocalDataSourceImpl implements IdeasLocalDataSource {
  final Map<String, List<CommentModel>> _commentsDb = {
    '1': [
      CommentModel(id: 'c1', text: '¡Totalmente! Yo pongo 50mil.', authorName: 'Carlos Dev', createdAt: DateTime.now()),
      CommentModel(id: 'c2', text: 'Ojo que hay que limpiar el filtro.', authorName: 'Ana Ops', createdAt: DateTime.now()),
    ]
  };
  final List<IdeaModel> _mockDb = [
    IdeaModel(
      id: '1',
      title: 'Máquina de Café en el 2do piso',
      description: 'La del primero siempre está llena.',
      voteCount: 15,
      category: IdeaCategory.culture,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    IdeaModel(
      id: '2',
      title: 'Refactorizar Auth',
      description: 'Aplicar Clean Architecture.',
      voteCount: 42,
      category: IdeaCategory.tech,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  @override
  Future<List<IdeaModel>> getIdeas() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockDb;
  }

  @override
  Future<void> addIdea(IdeaModel idea) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockDb.add(idea);
  }

  @override
  Future<IdeaModel> voteIdea(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _mockDb.indexWhere((element) => element.id == id);
    
    if (index == -1) {
      throw Exception("Idea no encontrada");
    }

    final idea = _mockDb[index];
    
    final updatedEntity = idea.copyWith(voteCount: idea.voteCount + 1);
    
    final updatedModel = IdeaModel.fromEntity(updatedEntity);
    
    _mockDb[index] = updatedModel;
    return updatedModel; 
  }

  @override
  Future<List<CommentModel>> getComments(String ideaId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _commentsDb[ideaId] ?? [];
  }

  @override
  Future<void> addComment(String ideaId, CommentModel comment) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    if (!_commentsDb.containsKey(ideaId)) {
      _commentsDb[ideaId] = [];
    }
    _commentsDb[ideaId]!.add(comment);
  }
}