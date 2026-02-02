import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/comments_entity.dart';
import '../../../domain/repositories/ideas_repository.dart';
import 'package:equatable/equatable.dart';
part 'ideas_detail_state.dart';

@injectable
class IdeaDetailCubit extends Cubit<IdeaDetailState> {
  final IdeasRepository _repository;

  IdeaDetailCubit(this._repository) : super(DetailInitial());

  Future<void> loadComments(String ideaId) async {
    emit(DetailLoading());
    final result = await _repository.getComments(ideaId);
    
    result.fold(
      (failure) => emit(DetailError(failure.message)),
      (comments) => emit(DetailLoaded(comments)),
    );
  }

  Future<void> postComment(String ideaId, String text) async {
    if (text.trim().isEmpty) return;
    final newComment = CommentEntity(
      id: const Uuid().v4(),
      text: text,
      authorName: 'Yo (Dev)', 
      createdAt: DateTime.now(),
    );

    final result = await _repository.addComment(ideaId, newComment);

    result.fold(
      (failure) => emit(DetailError(failure.message)),
      (_) => loadComments(ideaId),
    );
  }
}